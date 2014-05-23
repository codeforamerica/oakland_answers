require 'spec_helper'

include ArticlesHelper

describe ArticlesHelper do   

  it "returns an article list tag" do
    tag = article_list_tag(1, "description")
    tag.class.should == ActiveSupport::SafeBuffer
  end
  
  if "returns a missing article list tag" do
    tag = missing_article_list_tag(1, "description")
    tag.class.should == ActiveSupport::SafeBuffer
  end
 
end
