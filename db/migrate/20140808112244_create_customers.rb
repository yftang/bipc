class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :tel
      t.string :email
      t.string :add
      t.string :ins
      t.string :pro

      t.timestamps
    end
  end
end
