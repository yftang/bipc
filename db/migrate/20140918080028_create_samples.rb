class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.date :received_date
      t.string :receiver
      t.integer :receiver_id
      t.string :express_number

      t.timestamps
    end
  end
end
