require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit new_session_path }
    it { should have_selector('h1', text: 'Sign In') }
    it { should have_selector('title', text: 'Brackt - Sign In') }
  end
  describe "signin" do
    before { visit new_session_path }

    describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_selector('title', text: 'Sign In') }
      #it { should have_content('error') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      #it { should have_selector('title', text: user.name) }
      #it { should have_link('Profile', href: user_path(user)) }
      #it { should have_link('Sign out', href: signout_path) }
      #it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link('Sign In') }
      end
    end

    describe "after visiting another page" do
      before { click_link "HOME" }
      it { should_not have_content('error') }
      # change to this -> it { should_not have_selector('div.alert.alert-error') }
    end
  end

  describe "visiting users path" do
    before { visit users_path }
    it { should have_selector('title', text: 'Sign In') }
  end


end
