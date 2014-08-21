# == Schema Information
#
# Table name: project_role_users
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  role_user_id :integer
#

class ProjectRoleUser < ActiveRecord::Base
  belongs_to :role_user
  belongs_to :project
end
