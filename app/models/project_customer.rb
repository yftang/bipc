# == Schema Information
#
# Table name: project_customers
#
#  project_id  :integer
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ProjectCustomer < ActiveRecord::Base
  belongs_to :project
  belongs_to :customer

  validates_presence_of :project, :customer
end
