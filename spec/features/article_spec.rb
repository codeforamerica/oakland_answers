require 'spec_helper'

describe "Articles" do
  describe "user views an article details page" do
    let(:title)                { "Parking in Oakland" }
    let(:content_main)         { "Learn about parking" }

    let(:article) { FactoryGirl.create(:article, title: title,
                    content_main: content_main)
                  }

    before { visit article_path(article) }

    it "displays the article title" do
      expect(page).to have_content(title)
    end

    it "displays the main content" do
      expect(page).to have_content(content_main)
    end
  end

  describe "user views the articles list page" do
    before do
      parking_category = FactoryGirl.create(:category, name: "parking")
      camping_category = FactoryGirl.create(:category, name: "camping")
      FactoryGirl.create(:article, category: parking_category,
                          title: "first parking")
      FactoryGirl.create(:article, category: parking_category,
                          title: "second parking")
      FactoryGirl.create(:article, category: camping_category,
                          title: "just camping")

      visit articles_path
    end

    it "displays the categories as headers" do
      expect(page).to have_selector("h1 a", text: "parking")
      expect(page).to have_selector("h1 a", text: "camping")
    end

    it "has two articles under the the parking category" do
      expect(page).to have_css("ul.category-articles li.category-article h2 a", text: "first parking")
      expect(page).to have_css("ul.category-articles li.category-article h2 a", text: "second parking")
    end

    it "has one article under the camping category" do
      expect(page).to have_css("ul.category-articles li.category-article h2 a", text: "just camping")
    end

    it "displays the categories in the sidebar" do
      expect(page).to have_css(".sidebar-content ul li a", "parking")
      expect(page).to have_css(".sidebar-content ul li a", "camping")
    end
  end
end
