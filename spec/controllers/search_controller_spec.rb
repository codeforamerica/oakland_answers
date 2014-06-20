require 'spec_helper'

describe SearchController do
  describe "#reindex_articles" do
    it "reindexes articles via tanker" do
      expect(Article).to receive(:tanker_reindex)
      post :reindex_articles
    end
  end
end
