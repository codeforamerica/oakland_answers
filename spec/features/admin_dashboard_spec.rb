require 'spec_helper'

describe "Admin Dashboard" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43")
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "user views the admin dashboard page" do
    before do
      author = FactoryGirl.create(:user, email: "pui@example.com")
      FactoryGirl.create(:article, type: "Guide",
                         title: "How Parking?", user: author)
      FactoryGirl.create(:article, type: "QuickAnswer",
                         title: "How Camping?", content_main: "Yay camping!")

      visit admin_dashboard_path
    end

    it "displays a list of recent articles" do
      page.should have_content("Recent Articles")
    end

    it "displays details about the first article" do
      page.should have_content("How Parking?")
      page.should have_content("pui@example.com")
    end

    it "displays details about the second article" do
      page.should have_content("How Camping?")
    end

    it "displays the article details page when the article title is clicked" do
      click_link "How Camping?"
      page.should have_content("Yay camping!")
    end
  end
end
