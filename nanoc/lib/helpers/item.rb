
def item_by_id(id)
  @items.find { |i| i.identifier == id || i.identifier == (id + '/') }
end

def itemFor(id_or_item)
  id_or_item.is_a?(Nanoc3::Item) ? id_or_item : item_by_id(id_or_item)
end


def urlForItem(id_or_item)
  itemFor(id_or_item).path
end

def urlForTag(tag)
  urlForItem("/tags/#{tag}")
end
