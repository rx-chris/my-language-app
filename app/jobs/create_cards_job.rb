require "open-uri"

class CreateCardsJob < ApplicationJob
  queue_as :default

  def perform(selected_blueprint, lesson)
    # initialise OpenAI service
    service = OpenAiService.new

    # generate card data from OpenAI
    response = service.generate_cards({
      language: lesson.curriculum.language.name,
      lesson_title: lesson.title,
      lesson_description: lesson.description,
      card_count: selected_blueprint.count,
      instruction: selected_blueprint.blueprint.instruction,
      content_type: selected_blueprint.blueprint.content_type,
      answer_type: selected_blueprint.blueprint.answer_type
    })

    # create cards
    response[:cards].each do |data|
      card = Card.new(
        blueprint: selected_blueprint.blueprint,
        lesson:,
        model_answer: data[:model_answer]
      )
      # set card content
      case selected_blueprint.blueprint.content_type
      when "text_content"
        card.text_content = data[:text_content]
      when "audio_content"
        file_path = service.generate_audio(data[:audio_content])
        file = File.open(file_path)
        filename = File.basename(file_path)
        card.audio_content.attach(io: file, filename:, content_type: "audio/mpeg")
      when "image_content"
        url = service.generate_image(data[:image_content])
        file = URI.parse(url).open
        filename = "#{DateTime.now.strftime('%Q').to_i}_image.png"
        card.image_content.attach(io: file, filename:, content_type: "image/png")
      end
      card.save!

      # create mcq options for MCQ cards (only text options for now)
      if selected_blueprint.blueprint.answer_type == "mcq_answer"
        data[:mcq_options].each { |text_content| McqOption.create!(text_content:, card:) }
      end
    end
  end
end
