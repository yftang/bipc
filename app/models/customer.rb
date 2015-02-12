# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  phone        :string(255)
#  email        :string(255)
#  address      :string(255)
#  organization :string(255)
#  district     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Customer < ActiveRecord::Base
  has_many :project_customers
  has_many :projects, :through => :project_customers
  validates_presence_of :name, :email, :organization, :phone

  def to_param
    "#{id}-#{created_at.to_i}"
  end
end
