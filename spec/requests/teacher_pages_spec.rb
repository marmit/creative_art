require 'spec_helper'

describe "Teacher Pages" do
  subject { page }

  describe "New Teacher Page" do
    before { visit new_teacher_path }

    it { should have_selector('h1', text: 'Add A New Teacher') }
    it { should have_selector('title', text: 'New Teacher') }
  end

  describe "View Teacher Page" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { visit teacher_path(teacher)}

    it { should have_selector('h1', text: teacher.teacher_name.titleize) }
    it { should have_selector('title', text: teacher.teacher_name.titleize) }
  end

  describe "Create Teacher" do

    before { visit new_teacher_path }

    let(:submit) { "Create Teacher" }

    describe "with invalid information" do
      it "should not create a teacher" do
        expect { click_button submit }.not_to change(Teacher, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Full Name",    with: "Example Teacher"
        fill_in "Password",     with: "foobar1"
        fill_in "Confirmation", with: "foobar1"
      end

      it "should create a teacher" do
        expect { click_button submit }.to change(Teacher, :count).by(1)
      end
    end
  end
end
