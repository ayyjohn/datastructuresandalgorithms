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
    if index >= @length
      raise "index out of bounds"
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @store[@length]
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    # if the static array is full, create a new one with double the length
    # and add all the old items to it at their original indices
    if @length >= @capacity
      new_store = StaticArray.new(@capacity * 2)
      @capacity = @capacity * 2
      (0..@length).each { |index| new_store[index] = @store[index] }
      @store = new_store
    end
    @store[length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    shifted = @store[0]
    @length -= 1
    (1..@length).each { |index| @store[index - 1] = @store[index] }
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length >= @capacity
      new_store = StaticArray.new(@length * 2)
      (0..@length).each { |index| new_store[index + 1] = @store[index] }
      new_store[0] = val
      @store = new_store
      @capacity = capacity * 2
    else
      new_store = StaticArray.new(@length)
      (0..@length - 1).each { |index| new_store[index + 1] = @store[index] }
      @store = new_store
      @store[0] = val
    end
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
