# == Schema Information
#
# Table name: role_users
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class RoleUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  has_many :project_role_users
  has_many :projects, :through => :project_role_users
end
