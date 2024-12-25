class CurriculaController < ApplicationController
  def index
    render inertia: "Curricula/Index"
  end
end
