
module Feed

  require 'nokogiri'
  require 'cgi'

  def feed_content_proc(content)
    doc = Nokogiri::HTML.fragment(content)
    feed_content_proc_do_node(doc)
    doc.to_html
  end

  def feed_content_proc_do_node(node)
    return if node.name == 'code'
    if node.text?
      html = node.text.gsub(/\\\[(.*?)\\\]/) do |w|
        imgUrlForLatex($1)
      end
      html = html.gsub(/\\\((.*?)\\\)/) do |w|
        imgUrlForLatex($1)
      end
      node.replace Nokogiri::HTML.fragment(html)
    end
    node.children.each do |node|
      feed_content_proc_do_node(node)
    end
  end

  def imgUrlForLatex(latex)
    "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=#{CGI.escape(latex)}\"/>"
  end

end

include Feed
