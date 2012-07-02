# == Schema Information
#
# Table name: teachers
#
#  id           :integer         not null, primary key
#  teacher_name :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Teacher < ActiveRecord::Base
  attr_accessible :teacher_name, :password, :password_confirmation
  has_secure_password

  before_save { |teacher| teacher.teacher_name = teacher_name.downcase }

  validates :teacher_name, presence: true, length: { maximum: 50 },                       uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
