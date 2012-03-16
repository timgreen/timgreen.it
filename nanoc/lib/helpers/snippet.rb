require 'nokogiri'

module Snippet

  @@snippets = {}
  MIN_SNIPPET_LENGTH = 800

  def snippet_for(item)
    return @@snippets[item.path] if @@snippets[item.path]

    doc = Nokogiri::HTML.fragment(item.compiled_content)
    snippet = ''
    doc.traverse do |node|
      snippet += node.text if node.text? && snippet.length < MIN_SNIPPET_LENGTH
    end

    @@snippets[item.path] = snippet
    return @@snippets[item.path]
  end
end

include Snippet
