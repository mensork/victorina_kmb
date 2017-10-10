# Сделайте так, чтобы викторина из задачи 13-3 брала вопросы из XML-файла со списком вопросов и ответов.
# Для каждого вопроса задать строку вопроса, варианты ответов, правильный вариант, а также время на ответ.
# Если человек тратит на ответ больше времени, чем отведено, то программа завершается и пишет об этом пользователю.
# И не забывайте про ООП.

if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'rexml/document'
require 'absolute_time'
require_relative 'lib/question'
require_relative 'lib/questions_collection'

current_path = File.dirname(__FILE__)
file_name = current_path + '/data/questions.xml'

abort 'Файл questions.xml не найден.' unless File.exist?(file_name)

file = File.new(file_name, 'r:UTF-8')
doc = REXML::Document.new(file)
collection = QuestionsCollection.new
collection.read_from_xml(doc)
collection.create_collection

questions = collection.questions.shuffle
score = 0
count = 0

puts "Вы набрали #{score} из #{questions.size} баллов."

puts 'Добро пожаловать в Викторину! Ответьте на следующие вопросы:'
puts
while count < questions.size do
  question = questions[count]

  start_time = AbsoluteTime.now

  puts question.text_of_question
  question.show_variants
  puts
  puts "Время на ответ: #{question.time_for_reply} секунд"
  puts
  puts 'Выберите правильный вариант:'
  choice = STDIN.gets.to_i - 1
  end_time = AbsoluteTime.now

  if end_time - start_time > question.time_for_reply
    abort 'Время вышло! Вы проиграли'
  elsif question.variants[choice] == question.right_variant
    puts 'Верно! +1 балл.'
    puts
    score +=1
  else
    puts "Неверно. Правильный ответ: #{question.right_variant}"
    puts
  end
  count +=1
end

puts "Вы ответили на все вопросы и набрали #{score} из #{questions.size} баллов."