require 'hpricot_ext'

class UglifyHtml
  def initialize(html)
    @doc = Hpricot html
  end

  def make_ugly
    (@doc/"*").each do |e|
      case e.name
      when 'b', 'strong'
        if e.parent and e.parent.name == "span" and not e.previous_node and not e.next_node
          e.parent.set_style("font-weight", "bold")
          e.swap e.inner_html
        else
          e.change_tag! "span"
          e.set_style("font-weight", "bold")
        end
      when 'em', 'i'
        if e.parent and e.parent.name == "span" and not e.previous_node and not e.next_node
          e.parent.set_style("font-style", "italic")
          e.swap e.inner_html
        else
          e.change_tag! "span"
          e.set_style("font-style", "italic")
        end
      end
    end

    @doc.to_html
  end
end
