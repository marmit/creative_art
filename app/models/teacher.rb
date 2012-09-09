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

class Teacher < ActiveRecord::Base
  attr_accessible :username, :teacher_name, :password, :password_confirmation
  attr_reader :created_at
  has_secure_password

  before_save { self.username.downcase! }
  before_save { self.teacher_name.downcase! }
  before_save :create_remember_token

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :teacher_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create



  def to_param
    "#{self.id}-#{(self.teacher_name).gsub(/\s+/, "-")}"
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
