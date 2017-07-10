# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
    @length = length
  end

  # O(1)
  def [](index)
    validate!(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    validate!(index)
    @store[index] = value
  end

  protected

  attr_accessor :store

  private

  def validate!(index)
    raise "index out of bounds" unless index < @length && index >= 0
  end
end
