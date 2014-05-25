require 'spec_helper'

describe "Quick Answers" do
  before do
    FactoryGirl.create(:user, email: "erica@example.com", password: "Mahalo43",
                       password_confirmation: "Mahalo43")
    visit new_user_session_path
    fill_in "Email", with: "erica@example.com"
    fill_in "Password", with: "Mahalo43"
    click_button "Sign in"
  end

  describe "user views the admin article details page" do
      let(:author)  { FactoryGirl.create(:user, email: "pui@example.com") }
      let(:contact) { FactoryGirl.create(:contact) }
      let(:quick_answer) { FactoryGirl.create(:article, type: "QuickAnswer",
                                              title: "How Parking?",
                                              content_main: "Main Parking",
                                              content_main_extra: "Extra Parking",
                                              content_need_to_know: "Need Parking",
                                              preview: "Preview Parking",
                                              status: "Published",
                                              contact: contact,
                                              user: author) }

    before { visit admin_quick_answer_path(quick_answer) }

    it "shows quick answer details" do
      page.should have_content("How Parking?")
      page.should have_content("Main Parking")
      page.should have_content("Extra Parking")
      page.should have_content("Need Parking")
      page.should have_content("Preview Parking")
      page.should have_content("Published")
      page.should have_content("pui@example.com")
      page.should have_content(admin_contact_path(contact))
    end
  end

  describe "user creates a quick answer" do
    before do
      BigHugeThesaurus.stub(:synonyms).and_return(["transport"])

      FactoryGirl.create(:category, name: "Parking")
      FactoryGirl.create(:contact, name: "migurski")
      FactoryGirl.create(:keyword, name: "vehicles")
      visit new_admin_quick_answer_path
    end

    it "successfully creates a new quick answer when all fields are filled out" do
      fill_in "Title", with: "Let's Park"
      fill_in "Preview", with: "Parking Preview"
      select "Published", from: "Status"
      select "Parking", from: "Category"
      select "migurski", from: "Contact"
      select "vehicles", from: "Keywords"
      fill_in "Author", with: "Mike Migurski"
      fill_in "Overview/Summary", with: "Parking Summary"
      fill_in "Full Content", with: "Parking Content"
      fill_in "Related Resources", with: "Parking Resources"
      click_button "Create Quick answer"
      page.should have_content("Quick answer was successfully created.")
    end
  end

  describe "user edits a quick answer" do
    let(:author)  { FactoryGirl.create(:user, email: "pui@example.com") }
    let(:contact) { FactoryGirl.create(:contact) }
    let(:quick_answer) { FactoryGirl.create(:article, type: "QuickAnswer",
                       title: "How Parking?",
                       content_main: "Main Parking",
                       content_main_extra: "Extra Parking",
                       content_need_to_know: "Need Parking",
                       preview: "Preview Parking",
                       status: "Draft",
                       contact: contact,
                       user: author) }

    before { visit edit_admin_quick_answer_path(quick_answer) }

    it "successfully modifies a quick answer" do
      fill_in "Title", with: "Why Parking?"
      select "Published", from: "Status"
      click_button "Update Quick answer"
      page.should have_content("Quick answer was successfully updated.")
      page.should have_content("Why Parking?")
      page.should have_content("Published")
    end
  end

  # TODO figure out why delete fails. Something to do with object persistence
  # and delayed job
  describe "user deletes a quick answer" do
    let(:quick_answer) { FactoryGirl.create(:article, type: "QuickAnswer") }

    before { visit admin_quick_answer_path(quick_answer) }

    xit "successfully deletes a quick answer" do
      click_link "Delete Quick Answer"
    end
  end
end
