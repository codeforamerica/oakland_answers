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

  describe 'user creates a new category' do
    it 'redirects to the categories details page when all fields are filled out' do
      visit new_category_path
      fill_in("Name", with: "Parking")
      fill_in("Description (optional)", with: "Yay for parking")
      click_on("Submit")
      expect(page).to have_content("Parking")
    end

    it 'shows an error message and does not redirect if name is not filled out' do
      visit new_category_path
      fill_in("Description (optional)", with: "Yay for parking")
      click_on("Submit")
      expect(page).to have_content("Please fill in all required fields")
      expect(page).to have_content("Add a Category")
    end
  end

  describe "user edits an existing category" do
    before do
      category = FactoryGirl.create(:category)
      visit edit_category_path(category)
    end

    context "when all required fields are filled out" do
      it "displays the category details page after the category has been edited" do
        fill_in("Name", with: "park")
        click_on("Submit")
        expect(page).to have_content("Category successfully updated")
        expect(page).to have_content("park")
      end
    end

    context "when not all required fields are filled out" do
      it "renders an error message and does not redirect" do
        fill_in("Name", with: " ")
        click_on("Submit")
        expect(page).to have_content("Please fill in all required fields")
        expect(page).to have_content("Update a Category")
      end
    end
  end
end
