# == Schema Information
#
# Table name: project_samples
#
#  project_id :integer
#  sample_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProjectSample < ActiveRecord::Base
  belongs_to :project
  belongs_to :sample

  validates_presence_of :project, :sample
end
