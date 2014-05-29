require 'spec_helper'

include ArticlesHelper

describe ArticlesHelper do
  
  it "returns an article list tag" do
    tag = article_list_tag(1, "description")
    expect(tag.class).to(eq(ActiveSupport::SafeBuffer)) 
    expect(tag).to(have_tag('li') do
      with_tag('a', {href: '/articles/1'}) do
        with_text('description')
      end
    end)
  end
  
  it "returns a missing article list tag" do
    tag = missing_article_list_tag(1, "description")
    expect(tag.class).to(eq(ActiveSupport::SafeBuffer)) 
    expect(tag).to(have_tag('li', {with: {class: 'missing-article'}})) do
      with_text('description')
    end    
  end
 
end
