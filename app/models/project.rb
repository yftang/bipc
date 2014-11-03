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
#  report_sender         :string(255)
#  report_sender_id      :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Project < ActiveRecord::Base
  has_many :project_customers
  has_many :customers, :through => :project_customers

  has_many :project_samples
  has_many :samples, :through => :project_samples

  has_many :user_projects
  has_many :users, :through => :user_projects

  validates_presence_of :start_date, :deadline, :creater, :creater_id
  validates :acc, :presence => true, :uniqueness => true

  def samples_received?
    samples_received_date
  end

  def experiments_done?
    samples_received? && experiments_done_date
  end

  def analysis_done?
    experiments_done? && analysis_done_date
  end

  def report_sent?
    analysis_done? && report_sent_date
  end

  def to_param
    "#{id}-#{created_at.to_i}"
  end

  alias_method :complete?, :report_sent?
end
