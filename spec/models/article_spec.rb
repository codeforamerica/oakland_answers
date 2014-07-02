require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  subject       { article }

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
