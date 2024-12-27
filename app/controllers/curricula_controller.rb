class CurriculaController < ApplicationController
  before_action :set_curriculum, only: %i[show]

  def index
    @curricula = Curriculum.where(user: current_user)

    render inertia: "Curricula/Index", props: {
      curricula: @curricula.map do |curriculum|
        curriculum
          .as_json(include: :lessons)
          .merge(url: curriculum_path(curriculum))
      end
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

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end

  def curriculum_params
    params.require(:curriculum).permit(:title, :purpose, :context, :start_date, :end_date, :language_id, :selected_card_blueprint_id)
  end
end
