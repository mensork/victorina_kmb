class Question
  attr_reader :variants, :right_variant, :time_for_reply, :text_of_question

  def initialize(question_node)
    @variants = set_variants(question_node)
    @right_variant = set_right_variant(question_node)
    @time_for_reply = question_node.attributes['seconds'].to_i
    @text_of_question = question_node.elements['text'].text
  end

  def set_variants(question_node)
    question_node.get_elements('*/variant').map {|item| item.text}
  end

  def set_right_variant(question_node)
    right_answer_with_tags = question_node.get_elements('*/variant').
      select {|item| item.attributes['right']}
    right_answer_with_tags[0].text
  end

end
