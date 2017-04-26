require_relative "heap"

class Array
  def heap_sort!
    self.each_index do |idx|
      next if idx == 0
      heapify_up!(idx)
    end
    i = self.length - 1
    while i > 0
      self[i], self[0] = self[0], self[i]
      heapify_down!(0, i - 1)
      i -= 1
    end
  end

  private

  def heapify_up!(index)
    while index > 0
      parent = parent_index(index)
      if self[parent] < self[index]
        self[parent], self[index] = self[index], self[parent]
        index = parent
      else
        break
      end
    end
  end

  def heapify_down!(index, length)
    while index < length
      child = largest_child_index(index, length)
      break if child.nil?
      if self[child] > self[index]
        self[child], self[index] = self[index], self[child]
        index = child
      else
        break
      end
    end
  end

  def parent_index(index)
    (index - 1) / 2
  end

  def largest_child_index(index, length)
    c1 = index * 2 + 1
    c2 = index * 2 + 2
    return nil if c1 > length && c2 > length
    return c1 if c2 > length
    return c2 if c1 > length
    self[c1] < self[c2] ? c2 : c1
  end
end
