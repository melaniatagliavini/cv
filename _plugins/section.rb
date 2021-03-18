require "kramdown"

module Jekyll
    class SectionTagBlock < Liquid::Block
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        content = super
        "<section id=\"#{@text.strip}\">#{Kramdown::Document.new(content).to_html}</section>"
      end
    end
end
Liquid::Template.register_tag('section', Jekyll::SectionTagBlock)