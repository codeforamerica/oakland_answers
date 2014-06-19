require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  before        { Article.stub(:search_tank).and_return([article]) }
  subject       { article }


  it "is valid with a title" do
    expect(article).to be_valid
  end

  it 'allows mass assignment of common attributes' do
    Article.new.attributes.keys.each do |attrib|
      article { should allow_mass_assignment_of attrib.to_sym }
    end
  end

  describe ".search" do

    it "matches articles in the database" do
      Article.search(article.title).should include(article)
    end

    context "query does not match anything in the database" do
      it "returns an empty array" do
        Article.stub(:search_tank).and_return([])
        Article.search(SecureRandom.hex(16)).should be_empty
      end
    end

    context "query is an empty string" do
      subject { Article.search ''}
      it { should == Article.all }
    end

    context "query is a single space" do
      subject { Article.search ' ' }
      it { should == Article.all }
    end

    describe ".search titles" do
      it "returns an empty array when the search term is present in an article but not the title" do
        Article.stub(:search_tank).and_return([])
        Article.search_titles(article.preview).should be_empty
      end

      context "query is present in the title" do
        subject { Article.search_titles article.title }
        it { should include(article) }
      end
    end
  end

  describe "#remove_stop_words" do
    it "removes common english words from the string" do
      Article.remove_stop_words('why am I a banana').should eq('banana')
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
      not_accessed_article = Article.create(
          :title => "Forever alone article"
        )

      expect(not_accessed_article.access_count).to eq(0)
    end
  end
end
