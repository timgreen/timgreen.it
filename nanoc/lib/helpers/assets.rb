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

    def combined_css_item(profile)
      @items.find { |i| i.identifier == "/assets/css/#{profile}/combined/" }
    end

    def css_digest(profile)
      digest_for_item(combined_css_item(profile))
    end

    def imageUrl(path)
      # Remove .png, .jpg
      id = '/assets/images/' + path.split('.')[0..-2].join('.')
      "url(#{urlForItem(id)})"
    end
  end
end

include Helpers::Assets
