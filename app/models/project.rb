class Project < ActiveRecord::Base
  has_many :project_customers
  has_many :customers, through: :project_customers
end
