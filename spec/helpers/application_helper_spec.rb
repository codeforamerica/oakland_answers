require 'spec_helper'

include ApplicationHelper

describe ApplicationHelper do   

  it "returns official_site_title" do
    official_site_title.class.should == String
  end
  
  it "returns official style guide" do
    official_style_guide.class.should == String
  end
  
  it "returns official city name" do
    official_city_name.class.should == String
  end
  
  it "official contact email" do
    official_contact_email.class.should == String
  end
  
  it "returns official government long url" do
    official_government_long_url.class.should == String
  end
  
  it "returns official government short url" do
    official_government_short_url.class.should == String
  end
  
  it "returns link to official government website" do
    link = link_to_official_government_website
    link.class.should == ActiveSupport::SafeBuffer
  end
 
end
