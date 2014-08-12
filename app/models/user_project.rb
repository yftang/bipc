# == Schema Information
#
# Table name: user_projects
#
#  user_id    :integer
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end
