require 'spec_helper'

describe Markdownifier do
  it "converts markdown to html" do
    markdownifier = Markdownifier::Markdownifier.new
    input = "<h1>hello</h1>"
    output = markdownifier.html_to_markdown(input)
    expect(output.class).to eq(String)
    expect(output[0]).to eq("#")
  end
end
