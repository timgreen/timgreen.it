
module Blogging

  require 'set'

  def blog_items
    @items.select do |item|
      (item.identifier =~ /^\/blog\/\d{4,}\/\d{2,}\/.+\/$/) and (item[:kind]  == 'article')
    end
  end

  def blog_items_in(year, month)
    blog_items.select do |item|
      item.identifier.split('/')[2..3] == [year, month]
    end
  end

  def blog_month_items_in(year)
    @items.select do |item|
      item.identifier =~ /^\/blog\/\d{4,}\/\d{2,}\/$/
    end
  end

  def blog_year_items
    @items.select do |item|
      item.identifier =~ /^\/blog\/\d{4,}\/$/
    end
  end

  def create_blog_month_pages
    year_months = Set.new
    blog_items.each do |item|
      year_months << item.identifier.split('/')[2..3]
    end

    year_months.each do |year_month|
      year = year_month.first
      month = year_month.last
      items << Nanoc3::Item.new(
        "= render('template/blog_month_page', :year => '#{year}', :month => '#{month}')",
        {
          :title => "Articles: #{year}-#{month}",
          :is_hidden => true
        },
        "/blog/#{year}/#{month}/", # identifier
        :binary => false
      )
    end
  end

  def create_blog_year_pages
    years = Set.new
    blog_items.each do |item|
      years << item.identifier.split('/')[2]
    end

    years.each do |year|
      items << Nanoc3::Item.new(
        "= render('template/blog_year_page', :year => '#{year}')",
        {
          :title => "Articles: #{year}",
          :is_hidden => true
        },
        "/blog/#{year}/", # identifier
        :binary => false
      )
    end
  end

  def create_blog_page
    items << Nanoc3::Item.new(
      "= render('template/blog_page')",
      {
        :title => "Blog",
        :is_hidden => true
      },
      "/blog/", # identifier
      :binary => false
    )
  end
end

include Blogging
