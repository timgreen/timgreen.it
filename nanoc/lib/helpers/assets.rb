require 'digest/md5'

module Helpers
  module Assets

    def digest_for_item(item)
      digest = Digest::MD5.new
      digest << item.compiled_content
      digest.hexdigest
    end

    # css
    def less_items(profile)
      @items.select { |i|
        (i.identifier.start_with? "/assets/css/#{profile}") && i[:flag].nil?
      }
    end

    def create_combined_css(profile)
      items << Nanoc3::Item.new(
        [
          "- less_items('#{profile}').each do |i|",
          "  = i.compiled_content"
        ].join("\n"),
        {
          :flag => 'combined',
          :extension => 'css.haml',
          :is_hidden => true
        },
        "/assets/css/#{profile}/combined/",  # identifier
        :binary => false
      )
    end

    def combined_css_item(profile)
      @items.find { |i| i.identifier == "/assets/css/#{profile}/combined/" }
    end

    def css_digest(profile)
      digest_for_item(combined_css_item(profile))
    end

    @@COMPILE_JS_SCRIPT = File.dirname(__FILE__) + "/../../scripts/compile_js.sh"
    def compile_js
      # make depends to all js source
      @items.each { |i|
        i.compiled_content if i.identifier.start_with?("/assets/js/")
      }

      require 'systemu'
      stdout = StringIO.new
      stderr = StringIO.new
      cmd = [ 'bash', '-c', @@COMPILE_JS_SCRIPT ]
      systemu cmd, 'stdin' => '', 'stdout' => stdout, 'stderr' => stderr
      unless $? == 0
        stderr.rewind
        raise "Got error when compile js:\n\n#{stderr.string}"
      end
      stdout.rewind
      stdout.string
    end

    def image_url(path)
      # Drop .png, .jpg
      id = '/assets/images/' + path.split('.')[0..-2].join('.')
      "url(#{url_for_item(id)})"
    end
  end
end

include Helpers::Assets
