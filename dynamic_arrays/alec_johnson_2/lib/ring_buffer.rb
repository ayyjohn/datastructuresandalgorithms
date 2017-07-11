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
    p @store, @start_index
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
    resize! if @length >= @capacity
    @start_index = (@start_index - 1) % @capacity
    self[0] = val
    @length += 1
    p @store, @start_index
  end

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index!(index)
    raise "index out of bounds" unless @length > (index - @start_index)
  end

  def resize!
    old_store = @store
    old_length = @length
    old_start_index = @start_index
    @length = 0
    @start_index = 0
    @store = StaticArray.new(@capacity * 2)
    old_length.times do |i|
      self.push(old_store[(old_start_index + i) % @capacity])
    end
    @capacity = @capacity * 2
  end

  def physical_index(index)
    (index + @start_index) % @capacity
  end
end
