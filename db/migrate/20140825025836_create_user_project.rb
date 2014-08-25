class CreateUserProject < ActiveRecord::Migration
  def change
    create_table :user_projects, :id => false do |t|
      t.references :user, :project, :index => true
      t.string :role_name
    end
  end
end
