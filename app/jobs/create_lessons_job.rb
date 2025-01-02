class CreateLessonsJob < ApplicationJob
  queue_as :default

  def perform(lessons)
    lessons.each do |data, index|
      lesson = Lesson.create!(data)

      lesson.curriculum.selected_card_blueprints.each do |selected_blueprint|
        CreateCardsJob.perform_later(selected_blueprint, lesson)
      end
    end
  end
end
