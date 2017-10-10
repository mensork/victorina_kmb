class QuestionsCollection
  attr_reader :questions

  def read_from_xml(doc)
    @question_nodes = []
    doc.elements.each('questions/question') do |item|
      @question_nodes << item
    end
    @question_nodes
  end

  def create_collection
    @questions = []
    @question_nodes.each do |question_node|
      @questions << Question.new(question_node)
    end
    @questions
  end
end