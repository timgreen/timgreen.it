include Nanoc3::Helpers::Rendering

# css
def less_items
  items.clone.delete_if { |i|
    !((i.identifier =~ /^\/assets\/css\//) && !i[:combined])
  }
end
