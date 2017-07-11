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
    check_index!(physical_index(index))
    @store[physical_index(index)]
  end

  # O(1)
  def []=(index, val)
    @store[physical_index(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length < 1
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length >= @capacity
    self[@length] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length < 1
    shifted = self[0]
    @length -= 1
    @start_index += 1
    shifted
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
    old_store = @store
    old_capacity = @capacity
    @length = 0
    @capacity = @capacity * 2
    @store = StaticArray.new(@capacity)
    old_capacity.times do |i|
      self.push(old_store[i])
    end
  end

  def physical_index(index)
    (index + @start_index) % @capacity
  end
end
