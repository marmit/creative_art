# == Schema Information
#
# Table name: teachers
#
#  id              :integer         not null, primary key
#  teacher_name    :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  username        :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

require 'spec_helper'

describe Teacher do
  before { @teacher = Teacher.new(username: "samLassiter", teacher_name: "Sam Lassiter", password: "Foobar", password_confirmation: "Foobar") }

  subject { @teacher }

  it { should respond_to(:username) }
  it { should respond_to(:teacher_name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to true" do
    before do
      @teacher.save!
      @teacher.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when teacher username is not present" do
    before { @teacher.username = " " }
    it { should_not be_valid }
  end

  describe "when username is in use" do
    before do
      teacher_with_same_username = @teacher.dup
      teacher_with_same_username.username = @teacher.username.upcase
      teacher_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "username with  mixed case" do
    before { @teacher.username = "SaMLaSSiTer" }

    it "should be saved as all lower-case" do
      @teacher.save
      @teacher.reload.username.should == @teacher.username.downcase
    end
  end

  describe "when username is too long" do
    before { @teacher.username = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when teacher name is not present" do
    before { @teacher.teacher_name = " " }
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
    let(:found_teacher) { Teacher.find_by_username(@teacher.username) }

    describe "with valid password" do
      it { should == found_teacher.authenticate(@teacher.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_teacher.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @teacher.save }
    its(:remember_token) { should_not be_blank }
  end
end
