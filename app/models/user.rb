# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  phone                  :string(255)
#  jd                     :text
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  before_validation :set_default_password

  has_many :role_users
  has_many :roles, :through => :role_users

  has_many :user_projects
  has_many :projects, :through => :user_projects

  validates :email, :presence   => true,
                    :uniqueness => true
  validates :name,  :presence   => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(role)
    my_roles = self.roles
    my_roles.any? && (my_roles.first.name == role.to_s.camelize)
  end

  def role_one_of?(roles)
    if my_roles = self.roles
      roles.map(&:to_s).map(&:camelize).include? my_roles.first.name
    else
      return false
    end
  end

  def to_param
    "#{id}-#{created_at.to_i}"
  end

  private
  def set_default_password
    self.password = 'foobar'
    self.password_confirmation = 'foobar'
  end
end
