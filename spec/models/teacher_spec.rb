# == Schema Information
#
# Table name: teachers
#
#  id           :integer         not null, primary key
#  teacher_name :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Teacher do
  before { @teacher = Teacher.new(teacher_name: "Sam Lassiter", password: "Foobar", password_confirmation: "Foobar") }

  subject { @teacher }

  it { should respond_to(:teacher_name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when teacher name is not present" do
    before { @teacher.teacher_name = " " }
    it { should_not be_valid }
  end


  describe "name with  mixed case" do
    before { @teacher.teacher_name = "SaM LaSSiTer" }

    it "should be saved as all lower-case" do
      @teacher.save
      @teacher.reload.teacher_name.should == @teacher.teacher_name.downcase
    end
  end

  describe "when teacher name is too long" do
    before { @teacher.teacher_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is in use" do
    before do
      teacher_with_same_name = @teacher.dup
      teacher_with_same_name.teacher_name = @teacher.teacher_name.upcase
      teacher_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @teacher.password = @teacher.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @teacher.password_confirmation = "mismatch" }
    it { should_not be_valid}
  end

  describe "when password confirmation is nil" do
    before { @teacher.password_confirmation = nil }
    it { should_not be_valid}
  end

  describe "with a password that's too short" do
    before { @teacher.password = @teacher.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authentication method" do
    before { @teacher.save }
    let(:found_teacher) { Teacher.find_by_teacher_name(@teacher.teacher_name) }

    describe "with valid password" do
      it { should == found_teacher.authenticate(@teacher.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_teacher.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
