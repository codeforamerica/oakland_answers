require 'spec_helper'

describe SearchController do
  describe "#index" do
    it "successfully renders an index page with two articles that contain the search query" do
      article1 = FactoryGirl.create(:article, title: "cats in the hat")
      article2 = FactoryGirl.create(:article, title: "cats in the socks")
      get :index, q: "cat"
      expect(response).to have_http_status(:success)
      expect(assigns(:results)).to eq([article1, article2])
    end
  end
end
