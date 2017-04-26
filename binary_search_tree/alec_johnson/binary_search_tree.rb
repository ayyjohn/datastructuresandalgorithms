require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize()
    @root = BSTNode.new(nil, nil, nil, nil)
  end

  def find(node = @root, el)
    if el >= node.val
      if node.right.nil?
        return false
      else
        return find(node.right, el)
      end
    else
      if node.left.nil?
        return false
      else
        return find(node.left, el)
      end
    end
  end

  def insert(node = @root, el)
    # compare the node's value to root, if it's greater than, insert on right subtree
    # if it's less than, insert on left subtree

    # handle first insertion
    unless node.val
      node.val = el
      return
    end
    if el >= node.val
      if node.right.nil?
        node.right = BSTNode.new(el, nil, nil, node)
      else
        insert(node.right, el)
      end
    else
      if node.left.nil?
        node.left = BSTNode.new(el, nil, nil, node)
      else
        insert(node.left, el)
      end
    end
  end

  def delete(node = @root, el)
    if node.val == el
      p 'found'
      if node.left.nil? && node.right.nil?
        p 'leaf'
        if node.parent.val > node.val
          node.parent.left = nil
        else
          node.parent.right = nil
        end
      elsif node.left.nil? || node.right.nil?
        p 'has one child'
        children = node.left || node.right
        if node.parent.val < node.val
          node.parent.right = children
        else
          node.parent.left = children
        end
        children.parent = node.parent
      else
        p 'has two children'
        new_node = maximum(node)
        p new_node.val
        new_node.right = node.right unless node.right == new_node
        new_node.left = node.left unless node.left == new_node
        node.right.parent = new_node unless node.right == new_node
        node.left.parent = new_node unless node.left == new_node
        new_node.parent.right = nil
        new_node.parent = node.parent
        if new_node.parent.val > new_node.val
          new_node.parent.left = new_node
        else
          new_node.parent.right = new_node
        end
      end
    elsif el >= node.val
      p node.val, "right"
      return false if node.right.nil?
      delete(node.right, el)
    else
      p node.val, "left"
      return false if node.left.nil?
      delete(node.left, el)
    end
  end

  def is_balanced?(node = @root)
    return true if node.nil?
    left = depth(node.left)
    right = depth(node.right)
    diff = left - right
    return false unless 1 >= diff && -1 <= diff
    return false unless is_balanced?(node.left) && is_balanced?(node.right)
    true
  end

  def in_order_traversal(node = @root, tree = [])
    in_order_traversal(node.left, tree) unless node.left.nil?
    tree << node.val
    in_order_traversal(node.right, tree) unless node.right.nil?
    tree
  end

  def maximum(node = @root)
    current = node.left
    until current.right.nil?
      current = current.right
    end
    return current
  end

  def depth(node = @root)
    return 0 unless node && (node.right || node.left)
    left = node.left ? depth(node.left) : 0
    right = node.right ? depth(node.right) : 0
    return [left, right].max + 1
  end
end
