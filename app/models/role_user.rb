# == Schema Information
#
# Table name: role_users
#
#  role_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class RoleUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
