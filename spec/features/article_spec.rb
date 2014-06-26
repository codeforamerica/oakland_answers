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

  describe "user adds a new article" do
    before do
      FactoryGirl.create(:category, name: "parking")
      visit new_article_path
    end

    context "when all required fields are filled out" do
      it "displays the article details page after a new article is created" do
        fill_in("Question", with: "Where Can I Park?")
        fill_in("Answer", with: "Parking in Oakland")
        select("parking", from: "Category")
        click_on("Add")
        expect(page).to have_content("New question and answer successfully created")
        expect(page).to have_content("Where Can I Park?")
        expect(page).to have_content("Parking in Oakland")
      end

      it "displays the article on the index page after a new article is created" do
        fill_in("Question", with: "Where Can I Park?")
        fill_in("Answer", with: "Parking in Oakland")
        select("parking", from: "Category")
        click_on("Add")
        visit articles_path
        expect(page).to have_content("Where Can I Park?")
      end
    end

    context "when not all required fields are filled out" do
      it "renders an error message and does not redirect" do
        select("parking", from: "Category")
        click_on("Add")
        expect(page).to have_content("Please fill in all required fields")
        expect(page).to have_content("Add a Question and Answer")
      end
    end
  end

  describe "user edits an existing article" do
    before do
      article = FactoryGirl.create(:article_with_category)
      visit edit_article_path(article)
    end

    context "when all required fields are filled out" do
      it "displays the article details page after the article has been edited" do
        fill_in("Question", with: "Where Can I Park?")
        fill_in("Answer", with: "Parking in Oakland")
        click_on("Add")
        expect(page).to have_content("Question and answer successfully updated")
        expect(page).to have_content("Where Can I Park?")
        expect(page).to have_content("Parking in Oakland")
      end
    end

    context "when not all required fields are filled out" do
      it "renders an error message and does not redirect" do
        fill_in("Question", with: " ")
        click_on("Add")
        expect(page).to have_content("Please fill in all required fields")
        expect(page).to have_content("Edit Question and Answer")
      end
    end
  end
end
