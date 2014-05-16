require 'spec_helper'

describe "Searches" do

  describe "search results" do
    let(:article) { FactoryGirl.create :article, status: "Published" }
    let(:query) { article.title.downcase.gsub!(/[^\w ]*/, '') }

    context "1 result found" do
      before do
        Article.stub(:search_tank).and_return([article])
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      subject { page }

      it { should have_content "Search results for: \"#{query}\"" }
      it { should have_content article.title }
      it { should have_content article.preview }
    end

    context "no results found" do
      let(:reverse_query) { query.reverse*3 }

      before do
        Article.stub(:search_tank).and_return([])

        visit root_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      subject { page }

      it { should have_content "Search results for: \"#{reverse_query}\"" }
      it { should have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms." }
      it { should_not have_content article.title }
    end

    context "several results found" do
      let(:article_1) { FactoryGirl.create :article,
                        status: "Published",
                        title: "I Like Meows",
                        content: "Meows are the best guys."
                      }
      let(:article_2) { FactoryGirl.create :article,
                        status: "Published",
                        title: "I Prefer Monkeys",
                        content: "Monkeys are quite nice."
                      }
      let(:query_random) { "best nice" }

      before do
        Article.stub(:search_tank).and_return([article_1, article_2])
        visit root_path
        fill_in 'query', :with => query_random
        click_on 'SEARCH'
      end

      subject { page }

      it { should have_content "Search results for: \"#{query_random}\"" }
      it { should have_content article_1.title }
      it { should have_content article_1.preview }
      it { should have_content article_2.title }
      it { should have_content article_2.preview }
    end
  end
end
