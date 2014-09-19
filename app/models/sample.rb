# == Schema Information
#
# Table name: samples
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  received_date  :date
#  receiver       :string(255)
#  receiver_id    :integer
#  express_number :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Sample < ActiveRecord::Base
  has_many :project_samples
  has_many :projects, :through => :project_samples

  validates_presence_of :name

  def to_param
    "#{id}-#{created_at.to_i}"
  end
end
