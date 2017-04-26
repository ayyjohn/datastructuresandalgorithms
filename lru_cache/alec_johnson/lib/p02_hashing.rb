class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |value, index|
      total += value.hash ^ index.hash
    end
    total.hash
  end
end

class String
  def hash
    numbers = self.split('').map { |char| char.ord }
    numbers.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    numbers = self.map { |key, value| [key, value] }
    numbers.sort.hash
  end
end
