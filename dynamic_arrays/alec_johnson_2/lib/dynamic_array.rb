require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    check_index!(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    check_empty!
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= @capacity
    self[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_empty!
    shifted = self[0]
    (1...@length).each do |i|
      self[i - 1] = self[i]
    end
    @length -= 1
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    prev_length = @length
    resize! if @length >= @capacity
    prev_length.times do |i|
      self[i + 1] = self[i]
    end
    @length += 1
    self[0] = val
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  def check_index!(index)
    raise "index out of bounds" unless index < @length && index >= 0
  end

  # O(n): has to copy over all the elements to the new store.

  def check_empty!
    raise "index out of bounds" if @length <= 0
  end

  def resize!
    old_store = @store
    @store = StaticArray.new(@capacity * 2)
    @length = 0
    @capacity *= 2
    old_store.each do |el|
      self.push(el)
    end
  end
end
