# == Schema Information
#
# Table name: projects
#
#  id                         :integer          not null, primary key
#  acc                        :string(255)
#  start_date                 :date
#  end_date                   :date
#  samples_received_status    :boolean
#  experiments_done_status    :boolean
#  bioinformatics_done_status :boolean
#  report_finished_status     :boolean
#  report_sent_status         :boolean
#  created_at                 :datetime
#  updated_at                 :datetime
#

class Project < ActiveRecord::Base
  has_many :project_customers
  has_many :customers, :through => :project_customers

  has_many :project_role_users
  has_many :role_users, :through => :project_role_users
end
