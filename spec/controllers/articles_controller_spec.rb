require 'spec_helper'

describe ArticlesController do
  render_views

  describe "#show" do
    it "successfully renders an article details page" do
      article = FactoryGirl.create(:article)
      get :show, id: article.id
      response.should be_success
      assigns(:article).should eq(article)
    end
  end

  describe "#index" do
    it "successfully renders an index page with two articles" do
      category1 = FactoryGirl.create(:category_with_article)
      category2 = FactoryGirl.create(:category_with_article)
      get :index
      response.should be_success
      assigns(:categories).should eq([category1, category2])
    end
  end
end
