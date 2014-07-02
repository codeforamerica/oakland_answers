require 'spec_helper'

describe "Searches" do

  describe "English search results" do
    before do
      FactoryGirl.create(:article, title: "I like cats")
    end

    context "when one result is found" do
      let(:query) { "cat" }

      before do
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it "contains search results and search term" do
        expect(page).to have_content "Search results for: \"#{query}\""
        expect(page).to have_content "I like cats"
      end
    end

    context "when no results are found" do
      let(:query) { "dog" }

      before do
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it "contains the search term and a no results message" do
      expect(page).to have_content "Search results for: \"#{query}\""
      expect(page).to have_content "Sorry, no results found for \"#{query}\".  Please try rephrasing your search terms."
      end
    end

    context "when several results are found" do
      let(:query) { "best" }

      before do
        FactoryGirl.create(:article, title: "I Like Meows",
                            content_main: "Meows are the best guys.")
        FactoryGirl.create(:article, title: "I Prefer Monkeys",
                           content_main: "Monkeys are the best actually.")
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it "show the query" do
        expect(page).to have_content "Search results for: \"#{query}\""
      end

      it "contains the title of both articles" do
        expect(page).to have_content "I Like Meows"
        expect(page).to have_content "I Prefer Monkeys"
      end
    end
  end

  context "spanish search results" do
    let(:query) { "engaño" }

    before do
      FactoryGirl.create(:article, title: "This that you see",
                          content_main: "the false presentment planned With finest art and all the colored shows",
                          title_es: "Este que ves",
                          content_main_es: "engaño colorido, que, del arte ostentando los primores")
      visit root_path
      fill_in 'query', :with => query
      click_on 'SEARCH'
    end

    it "returns the article when a spanish query is performed" do
      expect(page).to have_content "Search results for: \"#{query}\""
      expect(page).to have_content "This that you see"
      expect(page).to have_content "Este que ves"
    end
  end
end
