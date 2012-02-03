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

  # Creates in-memory tag pages from partial: layouts/_tag_page.haml
  def create_tag_pages
    tag_set.each do |tag|
      items << Nanoc3::Item.new(
        "= render('tag_page', :tag => '#{tag}')",        # use locals to pass data
        { :title => "Tag: #{tag}", :is_hidden => true},  # do not include in sitemap.xml
        "/tags/#{tag}/",                                 # identifier
        :binary => false
      )
    end
  end

end

include TaggingExtra

