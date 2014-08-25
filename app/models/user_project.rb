# == Schema Information
#
# Table name: user_projects
#
#  user_id    :integer
#  project_id :integer
#  role_name  :string(255)
#
# Indexes
#
#  index_user_projects_on_project_id  (project_id)
#  index_user_projects_on_user_id     (user_id)
#

class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end
