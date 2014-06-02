require 'spec_helper'

include ApplicationHelper

describe ApplicationHelper do
  before :each do
    ENV.stub(:[])
    ENV.stub(:[]).with("OFFICIAL_SITE_TITLE").and_return("Generic Answers")
    ENV.stub(:[]).with("OFFICIAL_STYLE_GUIDE").and_return("The Style Guide")
    ENV.stub(:[]).with("OFFICIAL_CITY_NAME").and_return("Cityville")
    ENV.stub(:[]).with("OFFICIAL_CONTACT_MAIL").and_return("offical@contact.mail")
    ENV.stub(:[]).with("OFFICIAL_GOVERNMENT_URL").and_return("https://official.government.url")  
  end    

  it "returns official_site_title" do
    title = official_site_title
    expect(title.class).to(eq(String))
    expect(title).to(eq(ENV["OFFICIAL_SITE_TITLE"]))
  end
  
  it "returns official style guide" do
    guide = official_style_guide
    expect(guide.class).to(eq(String))
    expect(guide).to(eq(ENV["OFFICIAL_STYLE_GUIDE"]))
  end
  
  it "returns official city name" do
    name = official_city_name
    expect(name.class).to(eq(String))
    expect(name).to(eq(ENV["OFFICIAL_CITY_NAME"]))
  end
  
  it "official contact email" do
    email = official_contact_email
    expect(email.class).to(eq(String))
    expect(email).to(eq(ENV["OFFICIAL_CONTACT_MAIL"]))
  end
  
  it "returns official government long url" do
    url = official_government_long_url
    expect(url.class).to(eq(String))
    expect(url).to(eq(ENV["OFFICIAL_GOVERNMENT_URL"]))
  end
  
  it "returns official government short url" do
    url = official_government_short_url
    expect(url.class).to(eq(String))
    expect(url).to(eq("official.government.url"))
  end
  
  it "returns link to official government website" do
    link = link_to_official_government_website
    expect(link.class).to(eq(ActiveSupport::SafeBuffer))
    expect(link).to(have_tag('a', {with: {href: ENV["OFFICIAL_GOVERNMENT_URL"]+"/"}}))
  end
 
end
