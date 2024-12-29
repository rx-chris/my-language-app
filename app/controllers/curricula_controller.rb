class CurriculaController < ApplicationController
  before_action :set_curriculum, only: %i[show]

  def index
    @curricula = Curriculum.where(user: current_user)

    render inertia: "Curricula/Index", props: {
      curricula: @curricula.map do |curriculum|
        curriculum
          .as_json(include: :lessons)
          .merge(url: curriculum_path(curriculum))
      end,
      new_curriculum_url: new_curriculum_path
    }
  end

  def show
    render inertia: "Curricula/Show", props: {
      curriculum: @curriculum.as_json(include: :language).merge(
        lessons: @curriculum.lessons.map do |lesson|
          lesson.as_json.merge(url: lesson_path(lesson))
        end
      )
    }
  end

  def new
    @curriculum = Curriculum.new

    render inertia: "Curricula/New", props: {
      curriculum: @curriculum.as_json(only: [ :title, :purpose, :start_date, :end_date, :language_id ]),
      curricula_url: curricula_path,
      languages: Language.all
    }
  end

  def create
    curriculum = Curriculum.new(curriculum_params)
    curriculum.user = current_user

    if curriculum.save
      redirect_to curriculum_path(curriculum)
    else
      redirect_to new_curriculum_url, inertia: { errors: curriculum.errors }
    end
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end

  def curriculum_params
    params.require(:curriculum).permit(:title, :purpose, :context, :start_date, :end_date, :language_id, :selected_card_blueprint_id)
  end
end
