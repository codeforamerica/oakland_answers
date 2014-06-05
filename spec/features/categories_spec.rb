require 'spec_helper'

describe 'Categories' do
  describe 'user views a category page' do
  	let(:category) { create(:category, name: 'parking', description: 'Foo') }

    it 'displays category details' do
      visit category_path(category)
      expect(page).to have_content('parking')
      expect(page).to have_content('Foo')
    end

    it 'links to other categories in the sidebar using the slugged url' do
      other_category = create(:category, name: Faker::Lorem.words(3).join(' ').titleize, description: Faker::Lorem.sentence)
      visit category_path(category)
      expect(page).to have_content(other_category.name)
      expect(page.html.include?(other_category.slug)).to be true
    end
  end
end
