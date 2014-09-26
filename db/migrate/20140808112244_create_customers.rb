class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :organization
      t.string :province

      t.timestamps
    end
  end
end
