require 'spec_helper'

describe "Categories" do
  describe "user views the categories page" do
    it "displays category details" do
      category = FactoryGirl.create(:category, name: "parking", description: "Foo")
      visit category_path(category)
      page.should have_content("parking")
    end
  end
end
