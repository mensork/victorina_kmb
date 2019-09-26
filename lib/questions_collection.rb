class QuestionsCollection

  def self.read_from_xml(doc)
    question_nodes = doc.get_elements('questions/question').map {|item| item}
    self.get_questions(question_nodes)
  end

  def self.get_questions(question_nodes)
    question_nodes.map {|question_node| Question.new(question_node)}
  end
end