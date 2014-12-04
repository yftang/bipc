# == Schema Information
#
# Table name: districts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code_cn    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class District < ActiveRecord::Base
end
