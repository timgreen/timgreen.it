require 'nokogiri'

class CodeClassFixer < Nanoc3::Filter
  identifier :code_class_fix
  type :text => :text

  def run(content, params={})
    doc = Nokogiri::HTML.fragment(content)
    doc.css('pre > code').each do |code|
      lang = code.parent['lang']
      code.parent.remove_attribute('lang')
      unless lang.nil?
        code['class'] = "#{code['class'] ? code['class'] + ' ': ''}language-#{lang} language"
      end
    end

    doc.to_s
  end
end
