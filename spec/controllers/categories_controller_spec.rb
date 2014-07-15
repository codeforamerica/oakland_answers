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
    describe "when a user is signed in" do
      let(:user) { FactoryGirl.create(:user) }
      before     { allow(User).to receive(:find_by_email) { user } }

      it "successfully renders" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "when a user is not signed in" do
      it "redirects to the home page" do
        expect(get(:new)).to redirect_to(root_url)
      end
    end
  end

  describe "#create" do
    describe "when a user is signed in" do
      let(:user) { FactoryGirl.create(:user) }
      before     { allow(User).to receive(:find_by_email) { user } }

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

    describe "when a user is not signed in" do
      it "redirects to the home page" do
        category_hash = { name: "Parking", description: "Let's Park" }

        expect(post(:create, category: category_hash))
        .to redirect_to(root_url)
      end
    end
  end

describe "#edit" do
  let(:category) { FactoryGirl.create(:category) }

  describe "when a user is signed in" do
    let(:user) { FactoryGirl.create(:user) }
    before     { allow(User).to receive(:find_by_email) { user } }

    it "successfully renders" do
      get :edit, id: category.slug
      expect(response).to have_http_status(:success)
    end
  end

  describe "when a user is not signed in" do
    it "redirects to the home page" do
      expect(get(:edit, id: category.slug)).to redirect_to(root_url)
    end
  end
end

  describe "#update" do
    let(:category) { FactoryGirl.create(:category) }

    describe "when a user is signed in" do
      let(:user) { FactoryGirl.create(:user) }
      before     { allow(User).to receive(:find_by_email) { user } }

      it "redirects when valid params are passed" do
        expect(post(:update, id: category.slug, category: { description: "meowing" }))
        .to redirect_to category_path(category)
      end

      it "shows an error when invalid params are passed" do
        post :update, id: category.slug, category: { name: " " }
        expect(flash[:error]).to eq "Please fill in all required fields"
      end
    end

    describe "when a user is not signed in" do
      it "redirects to the home page" do
        expect(post(:update, id: category.slug, category: { description: "meowing" }))
        .to redirect_to(root_url)
      end
    end
  end
end
