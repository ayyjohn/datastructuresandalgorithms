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
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
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

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    # since it's a min heap we need to always swap with the smaller
    # child, because every element needs to be smaller than its children
    # thus if we swap with the larger child, we'll end up with a violated
    # heap property after the swap.
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end

  protected

  attr_accessor :prc, :store

end
