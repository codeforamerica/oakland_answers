require 'spec_helper'

describe "unauthenticated user views home page" do
  it "does not display the create Q&A link" do
    visit root_path
    expect(page).to_not have_content "Create a New Q&A"
  end

  it "displays the browse Q&A's link and sign in button" do
    visit root_path
    expect(page).to have_content("Browse Q&A's")
    expect(page).to have_button("Sign in")
  end
end

describe "authenticated user views home page" do
  it "lets the user create a Q&A" do
    allow(User).to receive(:find_by_email) { FactoryGirl.create(:user) }
    visit root_path
    click_link("Create a New Q&A")
  end
end
