# == Schema Information
#
# Table name: courses
#
#  id           :integer         not null, primary key
#  start_time   :datetime
#  start_date   :date
#  days_of_week :string(255)
#  title        :string(255)
#  description  :text
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  default_am   :boolean         default(TRUE)
#  active       :boolean         default(TRUE)
#
require 'spec_helper'

describe Course do
  let(:teacher) { FactoryGirl.create(:teacher) }
  before do
    @course = Course.new(title: 'New Title', description: 'Lorem ipsum', start_time: '3:30 AM', start_date: Date.today)
  end

  subject { @course }

  it { should respond_to(:start_time) }
  it { should respond_to(:start_date) }
  it { should respond_to(:active) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "when start_time is not present" do
    before { @course.start_time = nil }
    it { should_not be_valid }
  end
  describe "when start_date is not present" do
    before { @course.start_date = nil }
    it { should_not be_valid }
  end
  describe "when title is not present" do
    before { @course.title = nil }
    it { should_not be_valid }
  end
  describe "when description is not present" do
    before { @course.description = nil }
    it { should_not be_valid }
  end
end

# == Schema Information
#
# Table name: courses
#
#  id          :integer         not null, primary key
#  start_date  :date
#  title       :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  active      :boolean         default(TRUE)
#  start_time  :string(255)
#  day_of_week :integer
#

