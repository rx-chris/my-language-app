class CurriculaController < ApplicationController
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
end
