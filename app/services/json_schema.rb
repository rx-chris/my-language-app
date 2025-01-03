module Json_Schema
  LESSONS_SCHEMA = {
    name: "lessons_schema",
    schema: {
      type: "object",
      properties: {
        lessons: {
          description: "List of lessons",
          type: "array",
          items: {
            type: "object",
            properties: {
              title: {
                description: "Lesson title",
                type: "string"
              },
              description: {
                description: "Describes the learning content in the lesson",
                type: "string"
              }
            }
          }
        }
      }
    }
  }

  # Dynamically generate a cards schema based on the content_type and input_type
  def self.cards_schema(args = { content_type: "text_content", input_type: "text_answer" })
    args => { content_type:, input_type:}

    properties = {
      instruction: {
        description: "card instructions",
        type: "string"
      },
      model_answer: {
        description: "The correct answer to the card instructions",
        type: "string"
      },
      pronunciation: {
        description: "The pronunciation of model_answer",
        type: "string"
      }
    }
    content = {
      "text_content"=>{
        description: "a phrase or sentence for the learning card",
        type: "string"
      },
      "image_content"=>{
        description: "an image caption that can be used to generate an image",
        type: "string"
      },
      "audio_content"=>{
        description: "A phrase or sentence that will be converted to a audio file",
        type: "string"
      }
    }

    properties[content_type.to_sym] = content[content_type]


    properties[:mcq_options] = {
      description: "a list of answers that the user can choose from",
      type: "array",
      items: {
        type: "string"
      }
    } if input_type == "mcq_answer"

    # final schema
    {
      name: "cards_schema",
      schema: {
        type: "object",
        properties: {
          cards: {
            description: "list of cards",
            type: "array",
            items: {
              type: "object",
              properties:
            }
          }
        }
      }
    }
  end
end
