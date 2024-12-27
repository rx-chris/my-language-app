class CardsController < ApplicationController
  before_action :set_card, only: %i[show]

  def show
    mode = params[:mode]

    if mode.nil?
      redirect_to card_path(@card, mode: Card::LEARNING)
    else
      curriculum = @card.lesson.curriculum.as_json.merge(url: curriculum_path(@card.lesson.curriculum))
      lesson = @card.lesson.as_json.merge(url: lesson_path(@card.lesson), curriculum:)

      render inertia: "Cards/Show", props: {
        card: @card.as_json.merge(mode:, lesson:)
      }
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:user_answer)
  end
end
