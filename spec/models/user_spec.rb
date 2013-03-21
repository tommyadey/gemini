# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fullname        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe User do
  before do 
    @user = User.new(email: "user@example.com", fullname: "Example User", 
    username: "example", password: "password")
  end 
  subject { @user }
  it { should respond_to(:fullname) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:username) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should be_valid }

  describe "When fullname is not present" do
  	before { @user.fullname = " " }
  	it { should_not be_valid }
  end  
  describe "When fullname is too long" do
  	before { @user.fullname = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "When email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end  

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email adress is already taken" do
  	before do
  		user_with_same_email = @user.dup #makes a user with the same email address as @user
  		user_with_same_email.email = @user.email.upcase #same but capitalised
  		user_with_same_email.save
  	end
  	it { should_not be_valid }
  end

  describe "When password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "When password is too short" do
    before { @user.password  = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    # found_user = User.find_by_email(@user.email) kind of similar
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "When username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "When username is too short" do
    before { @user.username = "a" }
    it { should_not be_valid }
  end

  describe "When username is too long" do
    before { @user.username = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup 
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end
    it { should_not be_valid }
  end
  describe "remember_token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank }
    #code above is equivalent to it { @user.remember_token.should_not be_blank }
  end

end
