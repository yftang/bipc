class CreateProjectRoleUsers < ActiveRecord::Migration
  def change
    create_table :project_role_users do |t|
      t.integer :project_id
      t.integer :role_user_id
    end
  end
end
