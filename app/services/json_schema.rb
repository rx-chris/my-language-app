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
end
