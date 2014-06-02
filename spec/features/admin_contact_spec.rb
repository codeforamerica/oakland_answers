require 'spec_helper'

describe "Contacts" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43")
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "user views contact details page" do
    before do
      contact = FactoryGirl.create(:contact, name: "Employment Benefits",
                                   number: "555-1234", url: "www.example.com",
                                   address: "1234 Main St.", description: "A place")
      category = FactoryGirl.create(:category, name: "Parking",
                                    description: "Parking Description")
      author = FactoryGirl.create(:user, email: "pui@example.com")
      FactoryGirl.create(:article, type: "QuickAnswer",
                         title: "How Parking?",
                         status: "Published",
                         contact: contact,
                         user: author,
                         category: category)

      visit admin_contact_path(contact)
    end

    it "displays contact details and related articles" do
      page.should have_content("Employment Benefits")
      page.should have_content("555-1234")
      page.should have_content("www.example.com")
      page.should have_content("1234 Main St.")
      page.should have_content("A place")
      page.should have_content("How Parking?")
      page.should have_content("QuickAnswer")
      page.should have_content("pui@example.com")
      page.should have_content("Published")
    end
  end

  describe "user creates a new contact" do
    before { visit new_admin_contact_path }

    it "successfully creates a contact" do
      fill_in "Name", with: "Dept of Parking"
      fill_in "Phone Number", with: "555-1234"
      fill_in "Address", with: "1234 Main St."
      fill_in "Description", with: "Parking department"
      click_button "Create Contact"
      page.should have_content("Contact was successfully created.")
      page.should have_content("Dept of Parking")
    end
  end

  describe "user updates an existing contact" do
    before do
      contact = FactoryGirl.create(:contact, name: "Employment Benefits",
                                   number: "555-1234", url: "www.example.com",
                                   address: "1234 Main St.", description: "A place")
      visit edit_admin_contact_path(contact)
    end

    it "successfully updates an existing contact" do
      fill_in "Name", with: "Human Resources"
      click_button "Update Contact"
      page.should have_content("Contact was successfully updated.")
      page.should have_content("Human Resources")
    end
  end

  describe "user deletes a category" do
    before do
      contact = FactoryGirl.create(:contact, name: "Employment Benefits",
                                   number: "555-1234", url: "www.example.com",
                                   address: "1234 Main St.", description: "A place")
      visit admin_contact_path(contact)
    end

    it "successfully destroys a contact" do
      click_link "Delete Contact"
      page.should have_content("Contact was successfully destroyed.")
    end
  end
end
