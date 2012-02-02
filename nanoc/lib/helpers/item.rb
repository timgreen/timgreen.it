
def itemFor(id)
  @items.find { |i| i.identifier == id || i.identifier == (id + '/') }
end

def urlForItem(id)
  itemFor(id).path
end
