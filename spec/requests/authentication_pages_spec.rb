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
      before { teacher_sign_in teacher }

      it { should have_selector('title', text: teacher.teacher_name.titleize) }

      it { should have_link('Teachers', href: teachers_path) }
      it { should have_link('My page', href: teacher_path(teacher)) }
      it { should have_link('Sign out', href: teachers_signout_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should_not have_link("Sign out") }
        it { should_not have_link('My Stuff') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in teachers" do
      let(:teacher) { FactoryGirl.create(:teacher) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_teacher_path(admin)
          fill_in "Teacher User Name", with: teacher.username
          fill_in "Password", with: teacher.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit teacher')
          end
        end
      end

      describe "in the Teachers controller" do

        describe "visiting the edit page" do
          before { visit edit_teacher_path(teacher) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the teacher index" do
          before { visit teachers_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put teacher_path(teacher) }
          specify { response.should redirect_to(teachers_signin_path)}
        end
      end
    end

    describe "as wrong teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      let(:wrong_teacher) { FactoryGirl.create(:teacher, username: "wrongusername") }
      before { teacher_sign_in teacher }

      describe "visiting Teachers#edit page" do
        before { visit edit_teacher_path(wrong_teacher) }
        it { should_not have have_selector('title', text: full_title('Edit teacher')) }
      end

      describe "submitting a PUT request to the Teachers#update action" do
        before { put teacher_path(wrong_teacher) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "as non-admin teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      let(:non_admin) { FactoryGirl.create(:teacher)}

      before { teacher_sign_in non_admin }

      describe "submitting a DELETE request to a Teachers#destroy action" do
        before { delete teacher_path(teacher) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
