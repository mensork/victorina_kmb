class QuestionsCollection
  attr_reader

  def self.read_from_xml(doc)
    question_nodes = []
    doc.elements.each('questions/question') do |item|
      question_nodes << item
    end
    self.get_questions(question_nodes)
  end

  def self.get_questions(question_nodes)
    questions = []
    question_nodes.each do |question_node|
      questions << Question.new(question_node)
    end
    questions
  end
end