class BSTNode
  attr_accessor :val, :left, :right, :parent

  def initialize(val, left, right, parent = nil)
    @val = val
    @left = left
    @right = right
    @parent = parent
  end
end
