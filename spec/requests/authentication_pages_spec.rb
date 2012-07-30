require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit teachers_signin_path }

    it { should have_selector('h1', text: 'Teacher Sign in') }
    it { should have_selector('title', text: 'Teacher Sign in') }
  end

  describe "signin" do
    before { visit teachers_signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Teacher Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before do
        fill_in "Teacher User Name", with: teacher.username
        fill_in "Password", with: teacher.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: teacher.teacher_name.titleize) }
      it { should have_link('Sign out', href: teachers_signout_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should_not have_link("Sign out") }
        it { should_not have_link('My Stuff') }
      end
    end
  end
end
