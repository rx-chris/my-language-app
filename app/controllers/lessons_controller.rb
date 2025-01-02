class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show]

  def show
    curriculum = @lesson.curriculum.as_json.merge(url: curriculum_path(@lesson.curriculum))
    cards = @lesson.cards.map do |card|
        card.as_json(include: :blueprint).merge(
          learning_url: card_path(card, mode: Card::LEARNING),
          test_url: card_path(card, mode: Card::TEST)
        )
    end

    render inertia: "Lessons/Show", props: {
      lesson: @lesson.as_json(methods: [ :progress, :score ]).merge(curriculum:, cards:)
    }
  end

  def generate
    request_body = generate_params.to_h
    response = OpenAiService.new.generate_lessons(request_body)

    render json: response.as_json
  end

  def batch_create
    curriculum = Curriculum.find(params[:curriculum_id])
    selected_blueprints = params[:selected_blueprints]
    lessons = params[:lessons].map.with_index do |lesson, index|
      {
        title: lesson[:title],
        description: lesson[:description],
        curriculum: curriculum,
        order: index + 1
      }
    end

    if selected_blueprints.nil?
      lessons.each { |lesson| Lesson.create!(lesson) }
    else
      curriculum.selected_card_blueprints.delete_all
      selected_blueprints.each do |data|
        SelectedCardBlueprint.create!(
          curriculum:,
          blueprint: Blueprint.find(data[:id]),
          count: data[:count]
        )
      end
      CreateLessonsJob.perform_later(lessons)
    end

    redirect_to curriculum_path(curriculum)
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end

  def generate_params
    params.permit(:language_id, :lesson_count, :learning_objective)
  end

  def batch_create_lessons_params
    params.permit(:curriculum_id, lessons: [])
  end
end
