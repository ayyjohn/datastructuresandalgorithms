class BSTNode
  attr_reader :value
  attr_accessor :right, :left, :parent

  def initialize(value)
    @value = value
  end

  def inspect
    @value
  end
end
