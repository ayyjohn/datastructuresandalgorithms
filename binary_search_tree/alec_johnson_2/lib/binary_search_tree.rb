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
    end
  end

  def delete(value)
    return @root = nil if @root.value == value
    to_delete = find(value)
    parent = find_parent(value)
    if to_delete.left && to_delete.right
      replacement_node = maximum(to_delete.left)
      replacement_parent = find_parent(replacement_node.value)
      if to_delete.value == parent.right.value
        parent.right = replacement_node
      else
        parent.left = replacement_node
      end
      if replacement_node.left
        replacement_parent.right = replacement_node.left
      end
      replacement_node.left = to_delete.left
      replacement_node.right = to_delete.right
    elsif to_delete.left || to_delete.right
      if to_delete.value == parent.right.value
        if to_delete.left
          parent.right = to_delete.left
        else
          parent.right = to_delete.right
        end
      else
        if to_delete.left
          parent.left = to_delete.left
        else
          parent.left = to_delete.right
        end
      end
    else
      if to_delete.value == parent.right.value
        parent.right = nil
      else
        parent.left = nil
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node = tree_node.right while tree_node.right
    tree_node
  end

  def minimum(tree_node = @root)
    tree_node = tree_node.left while tree_node.left
    tree_node
  end

  def depth(tree_node = @root)
    return 0 unless tree_node && (tree_node.right || tree_node.left)
    1 + [depth(tree_node.right), depth(tree_node.left)].max
  end

  def is_balanced?(tree_node = @root)
    return true unless tree_node.left && tree_node.right
    (depth(tree_node.left) - depth(tree_node.right)).abs <= 1 &&
      is_balanced?(tree_node.left) &&
      is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr unless tree_node
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
    arr
  end

  private

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

  def find_parent(value, tree_node = @root)
    if tree_node.right.value == value || tree_node.left.value == value
      tree_node
    elsif value > tree_node.value && tree_node.right
      find_parent(value, tree_node.right)
    elsif value < tree_node.value && tree_node.left
      find_parent(value, tree_node.left)
    end
  end
end
