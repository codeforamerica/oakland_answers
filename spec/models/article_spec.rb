require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  before        { Article.stub(:search_tank).and_return([article]) }
  subject       { article }


  it "is valid with a title" do
    expect(article).to be_valid
  end

  it "has a friendly url" do
    article = Article.new(
        :title => "How to build an answer engine",
      )

    article.save

    expect(article.slug).to eq("how-to-build-an-answer-engine")
  end

  describe 'can be published' do
    context 'an unpublished article' do
      let(:unpublished_article) { FactoryGirl.create(:article) }

      it 'returns status Published' do
        unpublished_article.publish

        expect(unpublished_article.status).to eq('Published')
      end

      it 'is published' do
        unpublished_article.publish

        expect(unpublished_article.published?).to be_true
      end
    end
  end

  describe '.delete_orphaned_keywords' do
    context 'updating an article' do
      it 'destroys orphaned keywords associated'
    end

    context 'when deleting an article' do
      it 'destroys all keywords associated'
    end

  end


  # related articles no longer implemented
  # https://github.com/codeforamerica/oakland_answers/commit/36236fbe803b86ec0bc9e9cf5c8f07501432b026
  describe '.related' do
    subject  { article.related }
    context 'has no related articles' do

      it { should be_nil }
    end

    context 'has related articles' do
      it { should be_nil }

    end
  end

  describe ".hits" do
    context 'before an article has been viewed' do
      let(:new_article) { FactoryGirl.create(:article) }

      it 'has zero hits' do
        expect(new_article.hits).to eq(0)
      end
    end

    context 'returns number of views' do
      let(:old_article) { FactoryGirl.create(:article) }

      it 'has seven views' do
        old_article.access_count = 7
        old_article.save

        expect(old_article.hits).to eq(7)
      end

    end
  end


  # related articles no longer implemented
  # https://github.com/codeforamerica/oakland_answers/commit/36236fbe803b86ec0bc9e9cf5c8f07501432b026
  describe '.related' do
    subject  { article.related }
    context 'has no related articles' do

      it { should be_nil }
    end

    context 'has related articles' do
      it { should be_nil }

    end
  end

  describe ".hits" do
    context 'before an article has been viewed' do
      let(:new_article) { FactoryGirl.create(:article) }

      it 'has zero hits' do
        expect(new_article.hits).to eq(0)
      end
    end

    context 'returns number of views' do
      let(:old_article) { FactoryGirl.create(:article) }

      it 'has seven views' do
        old_article.access_count = 7
        old_article.save

        expect(old_article.hits).to eq(7)
      end

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

  describe ".find_by_type" do
    it 'returns articles matching type' do
      new_article = Article.create(
          :title => "Every answer you've ever been searching for and a bag of cats",
          :type => 'QuickAnswer'
        )

      result = Article.find_by_type( "QuickAnswer" )

      expect(result.map{|r| r.title }).to include "Every answer you've ever been searching for and a bag of cats"
      expect(result.map{|r| r.type }).to include "QuickAnswer"
<<<<<<< HEAD
=======
    end

    it 'excludes articles not matching specified type' do
      new_article = Article.create(
          :title => "Just a bag of cats",
          :type => "Bag"
        )

      result = Article.find_by_type( "QuickAnswer" )

      expect(result.map{|r| r.type }).to_not include "Bag"
>>>>>>> e9d068f... Adds specs for Article
    end
  end

  describe '#to_s' do
    context 'when an article has a category' do
      it 'returns a string containing title, id and category' do
        article.category_id = Category.find_or_create_by_name("Drivers License").id
        article.save

<<<<<<< HEAD
    it 'excludes articles not matching specified type' do
      new_article = Article.create(
          :title => "Just a bag of cats",
          :type => "Bag"
        )

      result = Article.find_by_type( "QuickAnswer" )

      expect(result.map{|r| r.type }).to_not include "Bag"
    end
  end

  describe '#to_s' do
    context 'when an article has a category' do
      it 'returns a string containing title, id and category' do
        article.category_id = Category.find_or_create_by_name("Drivers License").id
        article.save

        article.to_s.should eq("How do I get a driver license for the first time? (#{article.id}) [Drivers License]")
      end
    end
  end

  describe '#publish' do
    it 'updates the article status to Published'
  end

  describe '#before_validation' do
    it 'sets access count if nil' do
      not_accessed_article = Article.create(
          :title => "Forever alone article"
        )

      expect(not_accessed_article.access_count).to eq(0)
    end
=======
        article.to_s.should eq("How do I get a driver license for the first time? (#{article.id}) [Drivers License]")
      end
    end
  end

  describe '#publish' do
    it 'updates the article status to Published'
>>>>>>> e9d068f... Adds specs for Article
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

