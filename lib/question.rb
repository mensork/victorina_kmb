class Question
  attr_reader :variants,:right_variant, :time_for_reply, :text_of_question

  def initialize(question_node)
    @variants = get_variants(question_node)
    @right_variant = get_right_variant(question_node)
    @time_for_reply = question_node.attributes['seconds'].to_i
    @text_of_question = question_node.elements['text'].text
  end

  def get_variants(question_node)
    @variants = []
    question_node.elements.each('*/variant') { |item| @variants << item.text }
    @variants
  end

  def get_right_variant(question_node)
    question_node.elements.each('*/variant') do |item|
      @right_variant = item.text if item.attributes['right'] == 'true'
    end
    @right_variant
  end

  def show_variants
    @variants.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
  end
end

