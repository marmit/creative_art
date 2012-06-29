require 'spec_helper'

describe "TeacherPages" do
  subject { page }

  describe "New teacher page" do
    before { visit new_teacher_path }

    it { should have_selector('h1', text: 'Add a Teacher') }
    it { should have_selector('title', text: 'New Teacher') }
  end
end
