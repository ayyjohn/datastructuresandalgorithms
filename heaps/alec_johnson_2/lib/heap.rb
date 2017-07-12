require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = Array.new
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down!(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up!(@store, count - 1, count, &@prc)
  end

  def self.child_indices(len, parent_index)
    left_child = parent_index * 2 + 1
    right_child = parent_index * 2 + 2
    if right_child >= len && left_child >= len
      return nil
    elsif right_child >= len
      return [left_child]
    else
      return [left_child, right_child]
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down!(array, parent_index, len = array.length, &prc)
    # since it's a min heap we need to always swap with the smaller
    # child, because every element needs to be smaller than its children
    # thus if we swap with the larger child, we'll end up with a violated
    # heap property after the swap.
    prc ||= Proc.new { |x, y| x <=> y }
    children = BinaryMinHeap.child_indices(len, parent_index)
    return array unless children
    left_child = array[children[0]]
    right_child = children[1] ? array[children[1]] : "empty"
    swap_child_index = (right_child != "empty" && prc.call(left_child, right_child) > 0) ? children[1] : children[0]
    swap_child = array[swap_child_index]
    parent = array[parent_index]
    while prc.call(parent, swap_child) > 0
      array[parent_index], array[swap_child_index] = array[swap_child_index], array[parent_index]
      parent_index = swap_child_index
      children = BinaryMinHeap.child_indices(len, parent_index)
      return array unless children
      left_child = array[children[0]]
      right_child = children[1] ? array[children[1]] : "empty"
      swap_child_index = (right_child != "empty" && prc.call(left_child, right_child) > 0) ? children[1] : children[0]
      swap_child = array[swap_child_index]
      parent = array[parent_index]
    end
    array
  end

  def self.heapify_up!(array, child_index, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if child_index == 0
    parent_index = BinaryMinHeap.parent_index(child_index)
    child = array[child_index]
    parent = array[parent_index]
    while prc.call(parent, child) > 0
      array[child_index], array[parent_index] = array[parent_index], array[child_index]
      child_index = parent_index
      break if child_index == 0
      parent_index = BinaryMinHeap.parent_index(child_index)
      parent = array[parent_index]
      child = array[child_index]
    end
    array
  end

  protected

  attr_accessor :prc, :store

end
