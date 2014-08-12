class CreateCreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects, { id: false } do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
