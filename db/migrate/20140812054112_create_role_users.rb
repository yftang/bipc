class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users, :id => false do |t|
      t.references :role, :user, :index => true

      t.timestamps
    end
  end
end
