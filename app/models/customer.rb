# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  tel        :string(255)
#  email      :string(255)
#  add        :string(255)
#  ins        :string(255)
#  pro        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Customer < ActiveRecord::Base
  has_many :project_customers
  has_many :projects, :through => :project_customers
  validates_presence_of :name, :email, :ins, :tel
end
