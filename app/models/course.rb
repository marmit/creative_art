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

class Course < ActiveRecord::Base
  attr_accessible :active, :description, :start_time, :start_date, :title, :day_of_week
  attr_reader :created_at
  default_scope order: 'courses.created_at DESC'

  before_update :create_day_of_week

  validates :start_time, presence: true
  validates :start_date, presence: true
  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true, length: { minimum: 6 }

  def to_param
    "#{self.id}-#{(self.title).gsub(/\s+/, "-")}"
  end

  protected

  def create_day_of_week
    self.day_of_week = self.start_date.wday
  end
end

