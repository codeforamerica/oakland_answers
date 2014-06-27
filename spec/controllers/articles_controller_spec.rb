require 'spec_helper'

describe ArticlesController do
  render_views

  describe "#show" do
    it "successfully renders an article details page" do
      article = FactoryGirl.create(:article)
      get :show, id: article.id
      expect(response).to have_http_status(:success)
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "#index" do
    it "successfully renders an index page with two articles" do
      category1 = FactoryGirl.create(:category_with_article)
      category2 = FactoryGirl.create(:category_with_article)
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:categories)).to eq([category1, category2])
    end
  end

  describe "#new" do
    it "successfully renders" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "redirects when valid params are passed" do
      category = FactoryGirl.create(:category)
      article_hash = { title: "How to park?",
                       content_main: "This is how you park",
                       author_name: "Erica Kwan",
                       category_id: category.id
                     }
      expect(post(:create, article: article_hash))
      .to redirect_to article_path(assigns(:article))
    end

    it "shows an error when invalid params are passed" do
      article_hash = { title: " ",
                       content_main: "This is how you park",
                       author_name: "Erica Kwan"
                     }
      post :create, article: article_hash
      expect(flash[:error]).to eq "Please fill in all required fields"
    end
  end

  describe "#edit" do
    it "successfully renders" do
      article = FactoryGirl.create(:article)
      get :edit, id: article.slug
      expect(response).to have_http_status(:success)
    end
  end

  describe "#update" do
    it "redirects when valid params are passed" do
      article = FactoryGirl.create(:article)
      expect(post(:update, id: article.slug, article: { author_name: "Mow Meowerson" }))
      .to redirect_to article_path(article)
    end

    it "shows an error when invalid params are passed" do
      article = FactoryGirl.create(:article)
      post :update, id: article.slug, article: { title: " " }
      expect(flash[:error]).to eq "Please fill in all required fields"
    end
  end
end
