require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class UglifyHtmlTest < Test::Unit::TestCase
  def assert_renders_uglify(uglify, html)
    assert_equal uglify, UglifyHtml.new(html).make_ugly
  end

  context "convert common tags" do
    test "it should convert a simple <strong> tag" do
      html = "<p>some <strong>bold</strong> text inside a paragraph</p>"
      uglify = "<p>some <span style=\"font-weight:bold\">bold</span> text inside a paragraph</p>"
      assert_renders_uglify uglify, html 
    end

    test "it should convert a <strong> nested on a <em>" do
      html = "<p>some <em><strong>em bold</strong></em> text inside a paragraph</p>"
      uglify = "<p>some <span style=\"font-style:italic;font-weight:bold\">em bold</span> text inside a paragraph</p>"
      assert_renders_uglify uglify, html 
    end
  end
end
