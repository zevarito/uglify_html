require 'hpricot_ext'

class UglifyHtml
  def initialize(html)
    @doc = Hpricot html
  end

  def make_ugly
    (@doc/"*").each do |e|
      case e.name
      when 'b', 'strong' then process(e, "font-weight", "bold")
      when 'i', 'em'     then process(e, "font-style",  "italic")
      end 

    end

    @doc.to_html
  end

  private

  def process(e, style, value)
    if e.parent and e.parent.name == "span" and e.parent.children.size == 1
      e.parent.set_style(style, value)
      e.swap e.inner_html
    else
      e.change_tag! "span"
      e.set_style(style, value)
    end
  end
end
