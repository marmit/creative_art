require 'spec_helper'

describe "Teacher Pages" do

  subject { page }

  describe "index" do
    let(:teacher) { FactoryGirl.create(:teacher) }

    before(:all) { 30.times { FactoryGirl.create(:teacher) } }
    before(:all) { Teacher.delete_all }

    before(:each) do
      teacher_sign_in teacher
      visit teachers_path
    end

    it { should have_selector('title', text: 'All Teachers') }
    it { should have_selector('h1', text: 'All Teachers') }

    describe "pagination" do

      it "should list each teacher" do
        Teacher.paginate(page: 1).each do |teacher|
          page.should have_selector('li', text: teacher.teacher_name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin teacher" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          teacher_sign_in admin
          visit teachers_path
        end

        it { should have_link('delete', href: teacher_path(Teacher.first)) }
        it "should be able to delete another teacher" do
          expect { click_link('delete') }.to change(Teacher, :count).by(-1)
        end
        it { should_not have_link('delete', href: teacher_path(admin)) }
      end
    end
  end

  describe "New Teacher Page" do

    let(:admin) { FactoryGirl.create(:admin) }
    before do
      teacher_sign_in admin
      visit new_teacher_path
    end

    it { should have_selector('h1', text: 'Add A New Teacher') }
    it { should have_selector('title', text: 'New Teacher') }
  end

  describe "View Teacher Page" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before do
      teacher_sign_in teacher
      visit teacher_path(teacher)
    end

    it { should have_selector('h1', text: teacher.teacher_name.titleize) }
    it { should have_selector('title', text: teacher.teacher_name.titleize) }
  end

  describe "Create Teacher" do

    let(:admin) { FactoryGirl.create(:admin) }
    before do
      teacher_sign_in admin
      visit new_teacher_path
    end

    let(:submit) { "Create Teacher" }

    describe "with invalid information" do

      it "should not create a teacher" do
        expect { click_button submit }.not_to change(Teacher, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Login Name",   with: "exampleTeacher"
        fill_in "Full Name",    with: "Example Teacher"
        fill_in "Password",     with: "foobar1"
        fill_in "Confirmation", with: "foobar1"

        it "should create a teacher" do
          expect { click_button submit }.to change(Teacher, :count).by(1)
        end
      end
    end
  end

  describe "edit" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before do
      teacher_sign_in teacher
      visit edit_teacher_path(teacher)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update teacher information") }
      it { should have_selector('title', text: "Edit teacher") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_username) { "newMame" }
      before do
        fill_in "Login Name", with: new_username
        fill_in "Full Name",  with: new_name
        fill_in "Password",  with: teacher.password
        fill_in "Confirm Password",  with: teacher.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: teachers_signout_path) }
      specify { teacher.reload.teacher_name.should == new_name.downcase }
      specify { teacher.reload.username.should == new_username.downcase }
    end
  end
end
