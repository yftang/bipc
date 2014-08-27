# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  has_many :role_users
  has_many :users, :through => :role_users

  def get_users_options
    tmp_users = []
    self.users.each do |u|
      tmp_users << [u.name, u.id.to_s]
    end
    return tmp_users
  end

end
