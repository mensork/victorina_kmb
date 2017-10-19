class Question
  attr_reader :variants, :right_variant, :time_for_reply, :text_of_question

  def initialize(question_node)
    @variants = set_variants(question_node)
    @right_variant = set_right_variant(question_node)
    @time_for_reply = question_node.attributes['seconds'].to_i
    @text_of_question = question_node.elements['text'].text
  end

  def set_variants(question_node)
    variants = []
    question_node.elements.each('*/variant') { |item| variants << item.text }
    variants
  end

  def set_right_variant(question_node)
    right_variant = nil
        question_node.elements.each('*/variant') do |item|
      right_variant = item.text if item.attributes['right'] == 'true'
    end
    right_variant
  end
end

