require_relative "json_schema"

class OpenAiService
  def initialize
    @client = OpenAI::Client.new
  end

  # ----------------------------------------
  # Lesson Generation
  # ----------------------------------------

  def generate_lessons(request, unprocessed: false)
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: lessons_message_content(request) } ],
        temperature: 0.7,
        response_format: {
          type: "json_schema",
          json_schema: Json_Schema::LESSONS_SCHEMA
        }
      }
    )
    unprocessed ? response : response.dig("choices", 0, "message", "content")
  end

  def test_lessons_generation
    generate_lessons(mock_lessons_request)
  end

  def mock_lessons_request
    {
      language_id: 54,
      lesson_count: 10,
      learning_objective: "I will be going on holiday to Japan for 7 days I would like to learn common Japanese phrases that can help me communicate effectively with the locals."
    }
  end

  def lessons_message_content(request)
    request => { language_id:, lesson_count:, learning_objective: }
    language = Language.find(language_id)

    instructions = "Recommend me a learning plan consisting of #{lesson_count} lessons for learning #{language}."
    instructions += " The 'description' of each lesson should describe the lesson content in enough detail such it can be passed as a prompt to a language learning model to generate learning flashcards."
    context = "With regards to the lesson content, #{learning_objective}"

    "#{instructions} #{context}"
  end

  # ----------------------------------------
  # Cards Generation
  # ----------------------------------------
  def generate_cards(request, unprocessed: false)
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: cards_message_content(request) } ],
        temperature: 0.7,
        response_format: {
          type: "json_schema",
          json_schema: Json_Schema.cards_schema(request)
        }
      }
    )
    unprocessed ? response : response.dig("choices", 0, "message", "content")
  end

  def cards_message_content(req)
    contents = {
      "text_content" => "text_content: Provide a phrase or sentence in English or #{req[:language]}.",
      "audio_content" => "audio_content: Provide a phrase or sentence in #{req[:language]} that will represent an audio file.",
      "image_content" => "image_content: Provide an image caption to be used for image generation. Be as descriptive as possible"
    }
    in_language = req[:content_type] == "image_content" ? "in #{req[:language]} " : ""

    message = "I am designing a #{req[:language]} lesson with the following title and description:\n"
    message += "- title: \"#{req[:lesson_title]}\"\n"
    message += "- description: \"#{req[:lesson_description]}\"\n"
    message += "Recommend me #{req[:card_count]} #{req[:language]} learning cards for the above lesson as a JSON array that includes the following details for each card:\n"

    card_details = [ "instruction: Card instructions that says \"#{req[:instruction]}\"" ]
    card_details << contents[req[:content_type]]
    card_details << "model_answer: Provide the correct answer #{in_language}based on the 'instruction' and '#{req[:content_type]}'"
    card_details << "pronunciation: Provide the pronunciation of the 'model_answer' only if it is in #{req[:language]} or else this should be 'null'"

    if req[:input_type] == "mcq"
      card_details << "mcq_options: Provide a list of 4 answers to choose whereby 1 of the is the 'model_answer' and the rest are incorrect answers."
    end

    message += card_details.map.with_index { |content, index| "#{index + 1}. #{content}" }.join("\n")
    message
  end

  def test_cards_generation
    generate_cards(mock_cards_request)
  end

  def test_audio_cards_generation
    generate_cards(mock_audio_cards_request)
  end

  def test_image_cards_generation
    generate_cards(mock_image_cards_request)
  end

  def mock_cards_request
    {
      learning_objective: "I will be going on holiday to Japan for 7 days I would like to learn common Japanese phrases that can help me communicate effectively with the locals.",
      language: "Japanese",
      lesson_title: "Ordering Food",
      lesson_description: "Learn how to order food at a restaurant. Key phrases include 'Menu wo misete kudasai' (Please show me the menu), 'Kore wo kudasai' (I'll have this), and 'Oishii desu' (It's delicious). Explore common Japanese dishes and how to express dietary preferences.",
      card_count: 10,
      instruction: "Translate the following phrase or sentence",
      content_type: "text_content",
      input_type: "text"
    }
  end

  def mock_audio_cards_request
    {
      learning_objective: "I will be going on holiday to Japan for 7 days I would like to learn common Japanese phrases that can help me communicate effectively with the locals.",
      language: "Japanese",
      lesson_title: "Ordering Food",
      lesson_description: "Learn how to order food at a restaurant. Key phrases include 'Menu wo misete kudasai' (Please show me the menu), 'Kore wo kudasai' (I'll have this), and 'Oishii desu' (It's delicious). Explore common Japanese dishes and how to express dietary preferences.",
      card_count: 1,
      instruction: "Listen to the audio and select the correct answer.",
      content_type: "audio_content",
      input_type: "mcq"
    }
  end

  def mock_image_cards_request
    {
      learning_objective: "I will be going on holiday to Japan for 7 days I would like to learn common Japanese phrases that can help me communicate effectively with the locals.",
      language: "Japanese",
      lesson_title: "Ordering Food",
      lesson_description: "Learn how to order food at a restaurant. Key phrases include 'Menu wo misete kudasai' (Please show me the menu), 'Kore wo kudasai' (I'll have this), and 'Oishii desu' (It's delicious). Explore common Japanese dishes and how to express dietary preferences.",
      card_count: 1,
      instruction: "Select the answer that best describes the image",
      content_type: "image_content",
      input_type: "mcq"
    }
  end

  # ----------------------------------------
  # Image and audio generation
  # ----------------------------------------
  # size: "1024x1024", "1024x1792" or "1792x1024"
  # quality: "standard" or "hd"
  def generate_image(prompt, size: "1792x1024", quality: "standard", unprocessed: false)
    response = @client.images.generate(
      parameters: {
        prompt:,
        model: "dall-e-3",
        size:,
        quality:
      }
    )
    unprocessed ? response : response.dig("data", 0, "url")
  end

  def generate_audio(input, voice: "nova", speed: 1.0)
    audio_file = @client.audio.speech(
      parameters: {
        model: "tts-1",
        response_format: "mp3",
        input:,
        voice:,
        speed:
      }
    )
    filename = "#{DateTime.now.strftime('%Q').to_i}.mp3"
    filepath = Rails.root.join("tmp", filename)
    File.binwrite(filepath, audio_file)
  end
end
