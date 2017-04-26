# *NB*: what do you need to require here? This is a good chance to review a little Ruby require syntax.
require_relative 'binary_search_tree'

def kth_largest(bst, k)
  bst.in_order_traversal[-k]
end

def lowest_common_ancestor(node1, node2)
end

def post_order_traversal(node, tree = [])
  post_order_traversal(node.left, tree) if node.left
  post_order_traversal(node.right, tree) if node.right
  tree << node.val
  tree
end

def reconstruct(post_order)
  t = BinarySearchTree.new
  post_order.reverse.each { |el| t.insert(el) }
  t
end
