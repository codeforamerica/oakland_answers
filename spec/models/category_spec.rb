require 'spec_helper'

describe Category do
  it "a category should have a non nil access_count" do
    category = FactoryGirl.create(:category)
    category.access_count.should_not be_nil
  end

  describe "all_by_access_count scope" do
    it "returns categories in descending order of their access_counts" do
      first_category = FactoryGirl.create(:category, access_count: 5)
      second_category = FactoryGirl.create(:category, access_count: 3)
      Category.by_access_count.should == [first_category, second_category]
    end
  end
end
