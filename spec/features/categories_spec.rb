require 'spec_helper'

describe 'Categories' do
  describe 'user views a category page' do
    let(:category) { FactoryGirl.create(:category, name: 'parking', description: 'Foo') }

    it 'displays category details' do
      visit category_path(category)
      expect(page).to have_content('parking')
    end

    it 'links to other categories in the sidebar using the slugged url' do
      other_category = create(:category, name: Faker::Lorem.words(3).join(' ').titleize, description: Faker::Lorem.sentence)
      visit category_path(category)
      expect(page).to have_content(other_category.name)
      expect(page.html.include?(other_category.slug)).to be true
    end
  end

  describe 'user views the category index page' do
    before do
      category = FactoryGirl.create(:category, name: 'parking', description: 'Foo')
      FactoryGirl.create(:article, title: "How do I park?", category: category)
      FactoryGirl.create(:category, name: 'markets', description: 'where for food')
      visit categories_path
    end

    it 'displays the category names and descriptions' do
      expect(page).to have_content('parking')
      expect(page).to have_content('Foo')
      expect(page).to have_content('markets')
      expect(page).to have_content('where for food')
    end

    it 'has links to the category details pages' do
      click_link 'parking'
      expect(page).to have_content("How do I park?")
    end
  end
end
