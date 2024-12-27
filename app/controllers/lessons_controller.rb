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

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end
end
