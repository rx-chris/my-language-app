class CardsController < ApplicationController
  before_action :set_card, only: %i[show bookmark]

  def show
    mode = params[:mode]

    if [ Card::TEST, Card::LEARNING ].include?(mode&.to_sym)
      curriculum = @card.lesson.curriculum.as_json.merge(url: curriculum_path(@card.lesson.curriculum))
      lesson = @card.lesson.as_json.merge(url: lesson_path(@card.lesson), curriculum:)
      next_card = @card.lesson.cards.order(:id).find_by("cards.id > ?", @card.id)
      prev_card = @card.lesson.cards.order(id: :desc).find_by("cards.id < ?", @card.id)

      card_props = { mode:, lesson: }

      case @card.blueprint.content_type.to_sym
      when :audio_content then card_props[:audio_url] = Cloudinary::Utils.cloudinary_url("#{ENV['CLOUDINARY_FOLDER']}/#{@card.audio_content.key}", resource_type: "video")
      when :image_content then card_props[:image_url] = Cloudinary::Utils.cloudinary_url("#{ENV['CLOUDINARY_FOLDER']}/#{@card.image_content.key}")
      end

      render inertia: "Cards/Show", props: {
        card: @card.as_json(include: [ :blueprint, :mcq_options ]).merge(card_props),
        prev_card_url: prev_card ? card_path(prev_card) : lesson_path(@card.lesson),
        next_card_url: next_card ? card_path(next_card) : lesson_path(@card.lesson),
        bookmark_card_url: bookmark_card_path(@card)
      }
    else
      redirect_to card_path(@card, mode: Card::LEARNING)
    end
  end

  def bookmark
    @card.bookmarked = !@card.bookmarked

    if @card.save
      render json: { success: true }
    else
      render json: { success: false, errors: @card.errors }, status: :unprocessable_entity
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
