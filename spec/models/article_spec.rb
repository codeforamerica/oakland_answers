require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  before        { allow(Article).to receive(:search_tank) { [article] } }
  subject       { article }


  it "is valid with a title" do
    expect(article).to be_valid
  end

  describe ".search" do

    it "matches articles in the database" do
      expect(Article.search(article.title)).to include(article)
    end

    context "query does not match anything in the database" do
      it "returns an empty array" do
        allow(Article).to receive(:search_tank) { [] }
        expect(Article.search(SecureRandom.hex(16))).to be_empty
      end
    end

    # TODO this is not how it should work
    context "query is an empty string" do
      it "returns everything" do
        expect(Article.search(' ')).to eq(Article.all)
      end
    end

    describe ".search_titles" do
      it "returns an empty array when the search term is present in an article but not the title" do
        allow(Article).to receive(:search_tank) { [] }
        expect(Article.search_titles(article.preview)).to be_empty
      end

      it "returns the article when the query is present in the title" do
        expect(Article.search_titles(article.title)).to include(article)
      end
    end
  end

  describe "#remove_stop_words" do
    it "removes common english words from the string" do
      expect(Article.remove_stop_words('why am I a banana')).to eq('banana')
    end
  end

  describe '.indexable?' do
    it 'returns true if article is published' do
      article.status = "Published"

      expect(article.indexable?).to eq(true)
    end

    it 'returns false if article is not published' do
      article.status = 'Merp'
      article.save

      expect(article.indexable?).to eq(false)
    end
  end

  describe '#before_validation' do
    it 'sets access count if nil' do
      not_accessed_article = FactoryGirl.create(:article, title: "Forever alone article")
      expect(not_accessed_article.access_count).to eq(0)
    end
  end
end
