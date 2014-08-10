class ProjectCustomer < ActiveRecord::Base
  belongs_to :project
  belongs_to :customer

  validates_presence_of :project, :customer
end
