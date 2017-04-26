class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    if @next && @prev
      @next.prev = @prev
      @prev.next = @next
    end
    @next = nil
    @prev = nil
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @sentinal1 = Link.new
    @sentinal2 = Link.new
    @sentinal1.next = @sentinal2
    @sentinal2.prev = @sentinal1
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @sentinal1.next
  end

  def last
    empty? ? nil : @sentinal2.prev
  end

  def empty?
    @sentinal1.next == @sentinal2
  end

  def get(key)
    self.each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    !!get(key)
  end

  def append(key, val)
    new_link = Link.new(key, val)

    new_link.prev = @sentinal2.prev
    new_link.next = @sentinal2
    @sentinal2.prev.next = new_link
    @sentinal2.prev = new_link
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
        return link
      end
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove
        return link
      end
    end
  end

  def each(&prc)
    current = @sentinal1.next
    until current == @sentinal2
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
