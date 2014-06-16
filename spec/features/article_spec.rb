require 'spec_helper'

describe "Articles" do
  describe "user views a quick answer details page" do
    let(:title)                { "Parking in Oakland" }
    let(:content_main)         { "Learn about parking" }

    let(:article) { FactoryGirl.create(:article, type: "QuickAnswer",
                    title: title, content_main: content_main) }

    before { visit article_path(article) }

    it "displays the quick answer title" do
      page.should have_content(title)
    end

    it "displays the main content" do
      page.should have_content(content_main)
    end

    it "displays properly formated breadcrumbs" do
      pending 'currently creation of generic articles is disabled.'
      expect(page.html).to have_tag('div#breadcrumbs ol li')
    end

  end

  describe "user views the quick answers list page" do
    before do
      parking_category = FactoryGirl.create(:category, name: "parking")
      camping_category = FactoryGirl.create(:category, name: "camping")
      FactoryGirl.create(:article, type: "QuickAnswer", category: parking_category,
                          title: "first parking")
      FactoryGirl.create(:article, type: "QuickAnswer", category: parking_category,
                          title: "second parking")
      FactoryGirl.create(:article, type: "QuickAnswer", category: camping_category,
                          title: "just camping", preview: "I like camping")

      visit articles_type_path("quick-answer")
    end

    it "displays the categories as headers" do
      page.should have_selector("h1 a", text: "parking")
      page.should have_selector("h1 a", text: "camping")
    end

    it "has two quick answers under the the parking category" do
      page.should have_css("ul.category-articles li.article-listing h2 a", text: "first parking")
      page.should have_css("ul.category-articles li.article-listing h2 a", text: "second parking")
    end

    it "has one quick answers under the camping category" do
      page.should have_css("ul.category-articles li.article-listing h2 a", text: "just camping")
      page.should have_content("I like camping")
    end

    it "displays the categories in the sidebar" do
      page.should have_css(".sidebar-content ul li a", "parking")
      page.should have_css(".sidebar-content ul li a", "camping")
    end
  end
end
