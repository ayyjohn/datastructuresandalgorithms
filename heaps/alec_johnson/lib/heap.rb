class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc ||= Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop()
    BinaryMinHeap.heapify_down(@store, 0, count) 
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    # append, then heapify up
    @store.push(val)
    if count > 1
      BinaryMinHeap.heapify_up(@store, count - 1)
    end
  end

  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    index1 = parent_index * 2 + 1
    index2 = parent_index * 2 + 2
    children << index1 if index1 < len
    children << index2 if index2 < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    c1, c2 = BinaryMinHeap.child_indices(len, parent_idx)
    while c1 && c2
      if prc.call(array[c1], array[c2]) < 1
        if prc.call(array[c1], array[parent_idx]) < 1
          array[c1], array[parent_idx] = array[parent_idx], array[c1]
          parent_idx = c1
        else
          return array
        end
      else
        if prc.call(array[c2], array[parent_idx]) < 1
          array[c2], array[parent_idx] = array[parent_idx], array[c2]
          parent_idx = c2
        else
          return array
        end
      end
      c1, c2 = BinaryMinHeap.child_indices(len, parent_idx)
    end
    array[c1], array[parent_idx] = array[parent_idx], array[c1] if c1 && prc.call(array[c1], array[parent_idx]) < 1
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    until prc.call(array[parent_idx], array[child_idx]) < 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      begin
        parent_idx = BinaryMinHeap.parent_index(child_idx)
      rescue
        return array
      end
    end
    array
  end
end
