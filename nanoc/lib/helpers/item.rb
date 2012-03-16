
def item_by_id(id)
  @items.find { |i| i.identifier == id || i.identifier == (id + '/') }
end

def item_for(id_or_item)
  (id_or_item.is_a?(Nanoc3::Item) || id_or_item.is_a?(Nanoc3::ItemRep)) ? id_or_item : item_by_id(id_or_item)
end

def tag_item_for(tag)
  item_for("/tags/#{tag}")
end

def url_for_item(id_or_item)
  item_for(id_or_item).path
end

def full_url_for_item(id_or_item)
  @config[:base_url] + url_for_item(id_or_item)
end

def url_for_tag(tag)
  url_for_item(tag_item_for(tag))
end

def breadcrumbs_for(id_or_item)
  i = item_for(id_or_item)
  if i.identifier == '/'
    []
  else
    breadcrumbs_for(i.identifier.sub(/[^\/]+\/$/, '')) + [ i ]
  end
end

def link_to(text, target, attributes={})
  # Find path
  if target.is_a?(String)
    url = target
  else
    url = url_for_item(target)
    raise RuntimeError, "Cannot create a link to #{target.inspect} because this target is not outputted (its routing rule returns nil)" if url.nil?
  end

  # Join attributes
  attributes = attributes.inject('') do |memo, (key, value)|
    memo + key.to_s + '="' + h(value) + '" '
  end

  # Create link
  "<a #{attributes}href=\"#{h url}\">#{text}</a>"
end

def link_to_unless_current(text, target, attributes={})
  if @item_rep && url_for_item(@item_rep) == url_for_item(target)
    # Create message
    "<span class=\"active\" title=\"You're here.\">#{text}</span>"
  else
    link_to(text, target, attributes)
  end
end
