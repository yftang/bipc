class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :jd,    :text
  end
end
