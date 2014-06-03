require 'spec_helper'

describe Markdownifier do
  it "converts markdown to html" do
    markdownifier = Markdownifier::Markdownifier.new
    input = "<h1>hello</h1>"
    output = markdownifier.html_to_markdown(input)
    output.class.should == String
    output[0].should == "#"
  end
end
