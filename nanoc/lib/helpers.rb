include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::XMLSitemap

# css
def less_items
  items.reject { |i|
    !((i.identifier =~ /^\/assets\/css\//) && !i[:combined])
  }
end
