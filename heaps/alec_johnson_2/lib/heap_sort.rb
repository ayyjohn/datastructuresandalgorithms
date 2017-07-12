require_relative "heap"
require 'byebug'

class Array
  def heap_sort!
    partition_index = 0
    # since it's a max heap, let's use a max heap proc
    prc = Proc.new { |x, y| y <=> x }

    # heapify
    while partition_index < self.length - 1
      partition_index += 1
      BinaryMinHeap.heapify_up!(self, partition_index, partition_index, &prc)
    end

    # swap end of heap, move the partition, then heapify down
    while partition_index > 0
      self[0], self[partition_index] = self[partition_index], self[0]
      BinaryMinHeap.heapify_down!(self, 0, partition_index, &prc)
      partition_index -= 1
    end
  end
end
