class CreateProjectCustomers < ActiveRecord::Migration
  def change
    create_table :project_customers, { id: false } do |t|
      t.integer :project_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
