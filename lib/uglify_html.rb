require 'hpricot_ext'

class UglifyHtml
  def initialize(html)
    @doc = Hpricot html
  end

  def make_ugly
    (@doc/"*").each do |e|
      case e.name
      when 'b', 'strong' then process_with_style(e, "font-weight",      "bold")
      when 'i', 'em'     then process_with_style(e, "font-style",       "italic")
      when 'u', 'ins'    then process_with_style(e, "text-decoration",  "underline")
      when 'del'         then process_with_style(e, "text-decoration",  "line-through")
      end 

    end

    @doc.to_html
  end

  private

  def process_with_style(e, style, value)
    if e.parent and e.parent.name == "span" and e.parent.children.size == 1
      e.parent.set_style(style, value)
      e.swap e.inner_html
    else
      e.change_tag! "span"
      e.set_style(style, value)
    end
  end
end
