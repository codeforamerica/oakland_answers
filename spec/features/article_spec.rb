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

  describe "user views a guide details page" do
    let!(:guide) { FactoryGirl.create(:guide, title: "trains",
                   content_main: "trains are great") }
    let!(:step1) { FactoryGirl.create(:guide_step, title: "first step",
                   step: 1, article_id: guide.id, content: "do first") }
    let!(:step2) { FactoryGirl.create(:guide_step, title: "second step",
                   step: 2, article_id: guide.id, content: "do second") }

    before do
      visit guide_path(guide)
    end

    it "shows the guide title" do
      page.should have_content("trains")
    end

    it "lists the steps in the sidebar" do
      page.should have_css("#vtabs ul li a", text: "1. first step")
      page.should have_css("#vtabs ul li a", text: "2. second step")
    end

    it "lists the first step article header and preview" do
      page.should have_css("div h2.vtab-content-header", text: "first step")
      page.should have_css("div p", text: "do first")
    end

    it "lists the second step article header and preview" do
      page.should have_css("div h2.vtab-content-header", text: "second step")
      page.should have_css("div p", text: "do second")
    end
  end

  describe "user views the guides list page" do
    before do
      trains_category = FactoryGirl.create(:category, name: "trains")
      planes_category = FactoryGirl.create(:category, name: "planes")

      FactoryGirl.create(:guide, title: "all about trains", category: trains_category,
                         preview: "trains preview")
      FactoryGirl.create(:guide, title: "all about planes", category: planes_category,
                         preview: "planes preview")
      visit articles_type_path("guide")
    end

    it "displays the categories as headers" do
      page.should have_selector("h1 a", text: "trains")
      page.should have_selector("h1 a", text: "planes")
    end

    it "has two guides" do
      page.should have_css("ul.category-articles li.article-listing h2 a", text: "all about trains")
      page.should have_content("trains preview")

      page.should have_css("ul.category-articles li.article-listing h2 a", text: "all about planes")
      page.should have_content("planes preview")
    end
  end
end
