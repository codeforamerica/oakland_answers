require 'spec_helper'

describe CategoriesController do
  describe "#show" do
    it "successfully renders a category details page" do
      category = FactoryGirl.create(:category)
      get :show, id: category.id
      expect(response).to have_http_status(:success)
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "#index" do
    it "successfully renders an index page with two categories" do
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
      category_hash = { name: "Parking", description: "Let's Park" }

      expect(post(:create, category: category_hash))
      .to redirect_to category_path(assigns(:category))
    end

    it "shows an error when invalid params are passed" do
      category_hash = { name: " ", description: "Let's Park" }
      post :create, category: category_hash
      expect(flash[:error]).to eq "Please fill in all required fields"
    end
  end

describe "#edit" do
  it "successfully renders" do
    category = FactoryGirl.create(:category)
    get :edit, id: category.slug
    expect(response).to have_http_status(:success)
  end
end

  describe "#update" do
    it "redirects when valid params are passed" do
      category = FactoryGirl.create(:category)
      expect(post(:update, id: category.slug, category: { description: "meowing" }))
      .to redirect_to category_path(category)
    end

    it "shows an error when invalid params are passed" do
      category = FactoryGirl.create(:category)
      post :update, id: category.slug, category: { name: " " }
      expect(flash[:error]).to eq "Please fill in all required fields"
    end
  end
end
