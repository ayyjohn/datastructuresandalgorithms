require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      calc!(key)
    end
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count >= @max
    new_link = Link.new(key, @prc.call(key))
    @map[key] = new_link
    @store.append(new_link.key, new_link.val)
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
