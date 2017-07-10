require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_index = 0
  end

  # O(1)
  def [](index)
  end

  # O(1)
  def []=(index, val)
  end

  # O(1)
  def pop
  end

  # O(1) ammortized
  def push(val)
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index!(index)
    raise "index out of bounds" unless index < @length && index >= 0
  end

  def resize!
  end
end
