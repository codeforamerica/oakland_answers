require 'spec_helper'

describe "Searches" do

  describe "search results" do
    let(:article) { FactoryGirl.create :article, status: "Published" }
    let(:query) { article.title.downcase.gsub!(/[^\w ]*/, '') }

    context "1 result found" do
      before do
        allow(Article).to receive(:search_tank) { [article] }
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it "contains search results and search term" do
        expect(page).to have_content "Search results for: \"#{query}\""
        expect(page).to have_content article.title
        expect(page).to have_content article.preview
      end
    end

    context "no results found" do
      let(:reverse_query) { query.reverse*3 }

      before do
        allow(Article).to receive(:search_tank) { [] }

        visit root_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      it "contains the search term and a no results message" do
      expect(page).to have_content "Search results for: \"#{reverse_query}\""
      expect(page).to have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms."
      expect(page).to_not have_content article.title
      end
    end

    context "several results found" do
      let(:article_1) { FactoryGirl.create :article,
                        status: "Published",
                        title: "I Like Meows",
                        content_main: "Meows are the best guys."
                      }
      let(:article_2) { FactoryGirl.create :article,
                        status: "Published",
                        title: "I Prefer Monkeys",
                        content_main: "Monkeys are quite nice."
                      }
      let(:query)     { "best nice" }

      before do
        allow(Article).to receive(:search_tank) { [article_1, article_2] }

        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it "show the query" do
        expect(page).to have_content "Search results for: \"#{query}\""
      end

      it "contains the title and preview of both articles" do
        expect(page).to have_content article_1.title
        expect(page).to have_content article_1.preview
        expect(page).to have_content article_2.title
        expect(page).to have_content article_2.preview
      end
    end
  end
end
