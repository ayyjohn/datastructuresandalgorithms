require 'bst_node'
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      insert_helper(@root, value)
    end
    value
  end

  def find(value, tree_node = @root)
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:
  def insert_helper(node, value)
    if value >= node.value
      if node.right
        insert_helper(node.right, value)
      else
        node.right = BSTNode.new(value)
      end
    else
      if node.left
        insert_helper(node.left, value)
      else
        node.left = BSTNode.new(value)
      end
    end
    value
  end
end
