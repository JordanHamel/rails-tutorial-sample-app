require 'spec_helper'

describe "User pages" do 

	subject { page }

	describe "Signup page" do
		before { visit signup_path }

		it { should have_selector('h1', :text => "Sign Up") }
		it { should have_selector('title', :text => " | Sign Up")}
	end

	describe "profile page" do
	  let(:user) { FactoryGirl.create(:user) } 
	  before { visit user_path(user) }

	  it { should have_selector('h1',    text: user.name) }
	  it { should have_selector('title', text: user.name) }
	end

	describe "sign up" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid info" do
			it "should not make a user" do
				expect {click_button submit}.to_not change(User, :count)
			end
		end

		describe "with valid info" do
			before do
				fill_in "Name", with: "Flordan"
				fill_in "Email", with: "flordan@yahoo.com"
				fill_in "Password", with: "foobar"
				fill_in "Password confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end

