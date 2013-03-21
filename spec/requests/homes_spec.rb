require 'spec_helper'
describe "Home" do
  subject { page } #page is the subect of the test

  describe "Index" do 
  	before { visit root_path }

  	describe "for signed in user" do
  		let(:user) { FactoryGirl.create(:user) }
  		before do
  			sign_in(user)
        	visit root_path
  		end
	  	it { should have_selector('h1', text: "Welcome to a new gemini") }
	  	it { should have_selector('a', :href => root_path, :content => 'HOME') }
	  	it { should have_selector('a', :href => settings_path, :content => 'Settings') }
	  	#it { should have_selector('a', :href => signout_path, :content => 'Sign Out') } 
	  	#it { should_not have_link('Sign In') } 
	  	it { should_not have_link('Sign Up') } 
	end

	describe "Signed out user" do
		before { click_link "Sign Out" }
		it { should have_selector('a', :href => root_path, :content => 'HOME') }
		it { should have_selector('a', :href => signin_path, :content => 'Sign In') } 
		it { should have_selector('a', :href => signup_path, :content => 'Sign Up') } 
		it { should_not have_link('Sign Out') }
	end
  end

end