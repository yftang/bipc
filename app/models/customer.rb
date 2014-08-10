class Customer < ActiveRecord::Base
  has_many :project_customers
  has_many :projects, through: :project_customers
  validates_presence_of :name, :email, :ins, :tel
end
