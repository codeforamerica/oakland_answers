require 'spec_helper'

describe "Categories" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43")
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "user views category details page" do
    let(:contact) { FactoryGirl.create(:contact) }

    before do
      category = FactoryGirl.create(:category, name: "Parking",
                                    description: "Parking Description")
      author = FactoryGirl.create(:user, email: "pui@example.com")
      FactoryGirl.create(:article, type: "QuickAnswer",
                         title: "How Parking?",
                         status: "Published",
                         contact: contact,
                         user: author,
                         category: category)
      visit admin_category_path(category)
    end

    it "displays the category's details and related articles" do
      page.should have_content("Parking")
      page.should have_content("Parking Description")
      page.should have_content("How Parking?")
      page.should have_content("QuickAnswer")
      page.should have_content(admin_contact_path(contact))
      page.should have_content("pui@example.com")
      page.should have_content("Published")
    end
  end

  describe "user creates a category" do
    before { visit new_admin_category_path }

    it "successfully creates a category" do
      fill_in "Name", with: "Parking"
      fill_in "Description", with: "Parking Description"
      click_button "Create Category"
      page.should have_content("Category was successfully created.")
      page.should have_content("Parking")
    end
  end

  describe "user edits a category" do
    let(:category) { FactoryGirl.create(:category, name: "Parking",
                                        description: "Parking Description") }

    before { visit edit_admin_category_path(category) }

    it "successfully updates a category" do
      fill_in "Name", with: "Car Parking"
      click_button "Update Category"
      page.should have_content("Category was successfully updated.")
      page.should have_content("Car Parking")
    end
  end

  describe "user deletes a category" do
    let(:category) { FactoryGirl.create(:category, name: "Parking",
                                        description: "Parking Description") }

    before { visit admin_category_path(category) }

    it "successfully destroys a category" do
      click_link "Delete Category"
      page.should have_content("Category was successfully destroyed.")
    end
  end
end
