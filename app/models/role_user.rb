# == Schema Information
#
# Table name: role_users
#
#  role_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_role_users_on_role_id  (role_id)
#  index_role_users_on_user_id  (user_id)
#

class RoleUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  has_many :project_role_users
  has_many :projects, :through => :project_role_users
end
