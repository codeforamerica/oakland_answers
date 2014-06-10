require 'spec_helper'

describe GuidesHelper do
  describe '#meta_tag_hash' do
    let (:article) { create(:article) }
    let (:request) { double('request', :fullpath => '/path/to/resource') }

    before :each do
      controller.stub(:request).and_return request
    end

    it 'returns a hash using data from the article object' do
      expect(helper.meta_tag_hash(article)[:description]).to eq article.preview
      expect(helper.meta_tag_hash(article)[:canonical]).to eq(ENV["OFFICIAL_GOVERNMENT_URL"] + "/path/to/resource")
    end

    context 'when the article belongs to a category' do
      let (:article) { create(:article) }
      let (:category) { create(:category) }

      it 'the hash :title key returns an array with the category and title' do
        article.category = category
        expect(helper.meta_tag_hash(article)[:title]).to eq [article.category.name, article.title]
      end
    end

    context 'when the article does not belongs to a category' do
      let (:article) { create(:article) }
      let (:category) { create(:category) }

      it 'the hash :title key returns an array with only the title' do
        expect(helper.meta_tag_hash(article)[:title]).to eq [article.title]
      end
    end

  end
end
