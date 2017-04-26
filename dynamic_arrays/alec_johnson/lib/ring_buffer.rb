require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length <= 0
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    self[@length] = val
    @length += 1
    val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length <= 0
    shifted = self[0]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    new_store = StaticArray.new(@length * 2)
    i = 0
    (start_idx...start_idx + capacity).each do |index|
      new_store[i] = @store[index % capacity]
      i += 1
    end
    @capacity = @capacity * 2
    @store = new_store
    @start_idx = 0
  end
end
