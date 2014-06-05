require 'spec_helper'

describe CategoriesController do
  render_views

  describe 'GET show' do
    let(:category) { create(:category) }

    it 'renders the :show template' do
      get :show, id: category.slug

      expect(response).to render_template :show
    end

    it 'renders the :missing template' do
      get :show, id: 'this-category-does-not-exist'

      expect(response).to render_template :missing
    end
    
  end # describe
end # describe
