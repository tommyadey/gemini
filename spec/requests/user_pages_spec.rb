require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end
    it { should have_selector('h1',    text: 'All Users') }
    it { should have_selector('title',    text: 'All Users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
  end

  describe "signup page" do
  	before { visit signup_path }
  	it { should have_selector('title', text: "Sign Up") }
    it { should have_selector('h1', text: "Sign Up") }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.fullname) }
    it { should have_selector('title', text: user.fullname) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "When information is invalid" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        #above code means initial = User.count then click button "create my account"
        #final = User.count then initial should not be equal to final
        #that is user count should not increase for invalid info
      end

      describe "After submission" do
        before { click_button submit }
        it { should have_content('error') }
      end
    end

    describe "When information is valid" do
      before do
        fill_in "Fullname",  with: "Example User"
        fill_in "Username",  with: "exampleguy"
        fill_in "Email",     with: "user@example.com"
        fill_in "Password",  with: "password"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "After saving the user" do
        before { click_button submit }
        it { should have_content('Welcome To Project Gemini') }
        it { should have_link('Sign Out') }
      end
    end

  end
end
