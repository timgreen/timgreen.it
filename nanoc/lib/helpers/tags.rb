# From https://github.com/mgutz/nanoc3_blog/blob/master/lib/helpers.rb

module TaggingExtra

  require 'set'

  #Returns all the tags present in a collection of items.
  #The tags are only present once in the returned value.
  #When called whithout parameters, all the site items
  #are considered.
  def tag_set(items=nil)
    items = @items if items.nil?
    tags = Set.new
    items.each do |item|
      next if item[:tags].nil?
      item[:tags].each { |tag| tags << tag }
    end
    tags.to_a
  end

  def tag_items
    tag_set.map { |t| item_for("/tags/#{t}") }
  end

  def create_tag_pages
    tag_set.each do |tag|
      items << Nanoc3::Item.new(
        "= render('template/tag_page', :tag => '#{tag}')",  # use locals to pass data
        {
          :title => "Tag: #{tag}",
          :is_hidden => true,
          :extension => 'haml'
        },
        "/tags/#{tag}/",                                    # identifier
        :binary => false
      )
    end
  end

  def create_tags_page
    items << Nanoc3::Item.new(
      "= render('template/tags_page')",            # use locals to pass data
      {
        :title => "Tags",
        :is_hidden => true,
        :extension => 'haml'
      },
      "/tags/",                                    # identifier
      :binary => false
    )
  end

end

include TaggingExtra

