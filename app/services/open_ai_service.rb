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
end
