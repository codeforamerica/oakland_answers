require 'spec_helper'

describe "Categories" do
  describe "user views the categories page" do
    it "displays category details" do
      category = FactoryGirl.create(:category, name: "parking", description: "Foo")
      visit category_path(category)
      page.should have_content("parking")
    end
    it "displays properly formated breadcrumbs" do
    	category = FactoryGirl.create(:category, name: "parking", description: "Foo")
    	visit category_path(category)
    	expect(page.html).to have_tag('div.breadcrumbs ol li')
    end

  end

  describe "user views the categories index page" do
  	it "displays formated breadcrumbs" do
  		path = '/categories'
	  	visit path
	  	expect(page.html).to have_tag('div.breadcrumbs ol li')
  	end

  end

end
