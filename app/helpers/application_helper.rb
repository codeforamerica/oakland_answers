module ApplicationHelper
  def markdown_to_html(content)
    BlueCloth.new(content).to_html.html_safe
  end
end
