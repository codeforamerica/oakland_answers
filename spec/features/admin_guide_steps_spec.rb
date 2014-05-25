require 'spec_helper'

# TODO the future of guides is uncertain. These tests may become irrelevant
describe "Guide Steps" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43")
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "user views a guide step details page" do
    let(:guide)      { FactoryGirl.create(:guide, type: "Guide",
                       title: "Parking Guide") }
    let(:guide_step) { FactoryGirl.create(:guide_step, title: "Parking Step",
                       preview: "Parking Preview", content: "Find Parking",
                       step: 1, guide: guide) }

    before { visit admin_guide_step_path(guide_step) }

    it "displays guide step details" do
      page.should have_content("Parking Step")
      page.should have_content("Find Parking")
      page.should have_content("Parking Preview")
      page.should have_content("Parking Guide")
      page.should have_content("1")
    end
  end

  describe "user creates a new guide step" do
    before do
      FactoryGirl.create(:guide, type: "Guide", title: "Parking Guide")
      visit new_admin_guide_step_path
    end

    it "successfully creates a new guide step when all fields are filled out" do
      select "Parking Guide", from: "Guide"
      fill_in "Title", with: "Parking Step"
      fill_in "Step", with: "1"
      fill_in "Content", with: "Parking Content"
      click_button "Create Guide step"
      page.should have_content("Guide step was successfully created.")
      page.should have_content("Parking Step")
    end
  end

  describe "user edits a guide step" do
    let(:guide_step) { FactoryGirl.create(:guide_step, title: "Parking Step",
                       preview: "Parking Preview", content: "Find Parking",
                       step: 1) }

    before { visit edit_admin_guide_step_path(guide_step) }

    it "successfully changes a guide step" do
      fill_in "Title", with: "The best step"
      fill_in "Content", with: "More Parking"
      click_button "Update Guide step"
      page.should have_content("Guide step was successfully updated.")
      page.should have_content("The best step")
      page.should have_content("More Parking")
    end
  end

  describe "user deletes a guide step" do
    let(:guide_step) { FactoryGirl.create(:guide_step) }

    before { visit admin_guide_step_path(guide_step) }

    it "successfully deletes a guide step" do
      click_link "Delete Guide Step"
      page.should have_content("Guide step was successfully destroyed.")
    end
  end
end
