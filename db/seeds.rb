# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

# clear all tables
Card.destroy_all
Lesson.destroy_all
Curriculum.destroy_all
User.destroy_all
Language.destroy_all
Blueprint.destroy_all

puts 'cleared all tables'

# load data files
curricula_data_file_path = File.join(__dir__, 'data', 'curricula.json')
curricula_data = JSON.parse(File.read(curricula_data_file_path), symbolize_names: true)
cards_data_file_path = File.join(__dir__, 'data', 'cards.json')
cards_data = JSON.parse(File.read(cards_data_file_path), symbolize_names: true)
blueprints_data_file_path = File.join(__dir__, 'data', 'blueprints.json')
blueprints_data = JSON.parse(File.read(blueprints_data_file_path), symbolize_names: true)


# create a user
user = User.create!(
  email: 'jim@gmail.com',
  password: '123123',
  username: 'Jim'
)

puts 'created 1 user'

# create languages
LANGUAGE_NAMES = [
  'Mandarin',
  'English',
  'French',
  'Japanese',
  'German'
]

LANGUAGE_NAMES.each { |name| Language.create!(name:) }

puts "created #{Language.all.length} languages"

# create card blueprints
CARD_BLUEPRINT_NAMES = [
  "Answer",
  "Multiple Choice"
]

blueprints_data.each { |blueprint_data| Blueprint.create!(blueprint_data) }

puts "created #{Blueprint.all.length} card blueprints"

# create curricula
curricula_data.each do |curriculum_data|
  start_date = Date.today
  end_date = start_date + curriculum_data[:lessons].length.days

  curriculum_data => { title:, purpose:, context:, language: }
  lessons_data = curriculum_data[:lessons]

  curriculum = Curriculum.create!(
    title:,
    purpose:,
    context:,
    language: Language.find_by(name: language),
    start_date:,
    end_date:,
    user:
  )
  # create lessons
  lessons_data.each do |lesson_data|
    lesson_data => { title:, description:, order: }

    lesson = Lesson.create!(
      title:,
      description:,
      order:,
      curriculum:
    )

    # create cards
    cards_data.each do |card_data|
      Card.create!(
        model_answer: card_data[:model_answer],
        blueprint: Blueprint.find_by(name: card_data[:blueprint]),
        lesson:
      )
    end
  end
end

puts "created #{Curriculum.all.length} curricula"
puts "created #{Lesson.all.length} lessons"
puts "created #{Card.all.length} cards"
