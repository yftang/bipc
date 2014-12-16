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

require 'yaml'

class District < ActiveRecord::Base
  def self.chinese_districts
    root_path = Rails.root.to_s
    districts_file = "#{root_path}/app/assets/chinese_districts.yaml"
    districts = YAML.load_file(districts_file)
  end
end
