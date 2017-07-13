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
    if value > tree_node.value && tree_node.right
      find(value, tree_node.right)
    elsif value < tree_node.value && tree_node.left
      find(value, tree_node.left)
    elsif value == tree_node.value
      tree_node
    else
      nil
    end
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node = tree_node.right while tree_node.right
    tree_node
  end

  def depth(tree_node = @root)
    return 0 unless tree_node && (tree_node.right || tree_node.left)
    1 + [depth(tree_node.right), depth(tree_node.left)].max
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
