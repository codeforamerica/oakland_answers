require 'spec_helper'

describe "Articles" do
  describe "user views a quick answer details page" do
    let(:title)                { "Parking in Oakland" }
    let(:content_main)         { "Learn about parking" }
    let(:content_main_extra)   { "Extra parking info" }
    let(:content_need_to_know) { "All answers to parking" }

    let(:article) { FactoryGirl.create(:article, type: "QuickAnswer",
                    title: title, content_main: content_main,
                    content_main_extra: content_main_extra,
                    content_need_to_know: content_need_to_know) }

    before { visit article_path(article) }

    it "displays the quick answer title" do
      page.should have_content(title)
    end

    it "displays the main content" do
      page.should have_content(content_main)
    end

    it "displays the main extra content" do
      page.should have_content(content_main_extra)
    end

    it "displays the need to know content" do
      page.should have_content('What You Need to Know')
      page.should have_content(content_need_to_know)
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
                          title: "just camping")

      visit articles_path
    end

    it "displays the categories as headers" do
      page.should have_selector("h1 a", text: "parking")
      page.should have_selector("h1 a", text: "camping")
    end

    it "has two articles under the the parking category" do
      page.should have_css("ul.category-articles li.category-article h3 a", text: "first parking")
      page.should have_css("ul.category-articles li.category-article h3 a", text: "second parking")
    end

    it "has one article under the camping category" do
      page.should have_css("ul.category-articles li.category-article h3 a", text: "just camping")
    end

    it "displays the categories in the sidebar" do
      page.should have_css(".sidebar-content ul li a", "parking")
      page.should have_css(".sidebar-content ul li a", "camping")
    end
  end
end
