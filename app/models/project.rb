# == Schema Information
#
# Table name: projects
#
#  id                    :integer          not null, primary key
#  acc                   :string(255)
#  start_date            :date
#  deadline              :date
#  creater               :string(255)
#  creater_id            :integer
#  salesman              :string(255)
#  salesman_id           :integer
#  samples_received_date :date
#  samples_receiver      :string(255)
#  samples_receiver_id   :integer
#  experiments_done_date :date
#  experimenter          :string(255)
#  experimenter_id       :integer
#  analysis_done_date    :date
#  bioinformatician      :string(255)
#  bioinformatician_id   :integer
#  report_sent_date      :date
#  marketing             :string(255)
#  marketing_id          :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Project < ActiveRecord::Base
  has_many :project_customers
  has_many :customers, :through => :project_customers

  has_many :user_projects
  has_many :users, :through => :user_projects

end
