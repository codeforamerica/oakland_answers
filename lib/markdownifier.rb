require 'reverse_markdown'

module Markdownifier
  class Markdownifier

    def html_to_markdown( html, options = {} )
      ReverseMarkdown.convert(html)
    end

  end
end