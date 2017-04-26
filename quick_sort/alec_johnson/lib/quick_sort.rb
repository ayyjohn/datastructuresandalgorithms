class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]

    left = array.drop(1).select { |el| el <= pivot }
    right = array.drop(1).select { |el| el > pivot }

    return QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return if length <= 1
    # p array
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    # p pivot_idx
    # p length
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    partition = start
    i = start + 1
    while i < length + start
      if prc.call(array[i], pivot) < 1
        partition += 1
        array[partition], array[i] = array[i], array[partition]
      end
      i += 1
    end
    array[start], array[partition] = array[partition], array[start]
    partition
  end
end
