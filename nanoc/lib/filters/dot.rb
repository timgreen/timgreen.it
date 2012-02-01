require 'nokogiri'
require 'systemu'

class DotRender < Nanoc3::Filter
  identifier :dot
  type :text => :text

  def run(content, params={})
    doc = Nokogiri::HTML.fragment(content)
    doc.css('dot').each do |dot|
      dot_content = dot.inner_text
      svg_content = dot2svg(dot_content)
      dot.replace(Nokogiri::HTML.fragment(svg_content, 'utf-8'))
    end

    doc.to_s
  end

  private
  def dot2svg(content)
    check_availability('dot', '-V')

    # Build command
    cmd = [ 'dot', '-Tsvg' ]

    # Run command
    stdout = StringIO.new
    systemu cmd, 'stdin' => content, 'stdout' => stdout

    # Get result
    stdout.rewind
    xml = Nokogiri::HTML.fragment(stdout.read, 'utf-8')
    svg = xml.css('svg').first
    remove_comments(svg)
    svg.to_s
  end

  def remove_comments(node)
    if (node.comment?)
      node.remove
    else
      node.children.each { |x| remove_comments(x) }
    end
  end

  def check_availability(*cmd)
    systemu cmd
    raise "Could not spawn #{cmd.join(' ')}" if $?.exitstatus != 0
  end
end
