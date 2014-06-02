require 'spec_helper'

describe "Users" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43", is_admin: true)
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "admin user views user details page" do
    before do
      user = FactoryGirl.create(:user, email: "pui@example.com", is_editor: true,
                                is_writer: true)
      visit admin_user_path(user)
    end

    it "displays user details" do
      page.should have_content("pui@example.com")
    end
  end

  describe "admin user creates a new user" do
    before { visit new_admin_user_path }

    # TODO guh, creation doesn't have a success/failure message
    it "successfully creates a user" do
      fill_in "Email", with: "pui@example.com"
      fill_in "user_password", with: "Mahalo43"
      fill_in "user_password_confirmation", with: "Mahalo43"
      check "Writer"
      click_button "Create User"
      page.should have_content("User Details")
    end
  end

  describe "admin user updates an existing user" do
    before do
      user = FactoryGirl.create(:user, email: "pui@example.com", is_editor: true,
                                is_writer: true)
      visit edit_admin_user_path(user)
    end

    # TODO Blarh, same as creation
    it "successfully updates an existing user" do
      fill_in "Email", with: "pui_ling@example.com"
      click_button "Update User"
      page.should have_content("User Details")
    end
  end

  describe "admin user deletes a user" do
    before do
      user = FactoryGirl.create(:user, email: "pui@example.com", is_editor: true,
                                is_writer: true)
      visit admin_user_path(user)
    end

    it "successfully destroys a user" do
      click_link "Delete User"
      page.should have_content("User was successfully destroyed.")
    end
  end
end
