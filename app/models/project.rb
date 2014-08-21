# == Schema Information
#
# Table name: projects
#
#  id                    :integer          not null, primary key
#  acc                   :string(255)
#  start_date            :date
#  deadline              :date
#  salesman              :string(255)
#  salesman_id           :integer
#  samples_received_date :date
#  samples_received_by   :string(255)
#  marketing_id          :integer
#  experiments_done_date :date
#  experiments_done_by   :string(255)
#  experimenter_id       :integer
#  analysis_done_date    :date
#  analysis_done_by      :string(255)
#  bioinformatician_id   :integer
#  report_sent_date      :date
#  report_sent_by        :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Project < ActiveRecord::Base
  has_many :project_customers
  has_many :customers, :through => :project_customers

  has_many :project_role_users
  has_many :role_users, :through => :project_role_users
end
