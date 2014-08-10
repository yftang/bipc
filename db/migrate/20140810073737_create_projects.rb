class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :acc
      t.date :start_date
      t.date :end_date
      t.boolean :samples_received_status
      t.boolean :experiments_done_status
      t.boolean :bioinformatics_done_status
      t.boolean :report_finished_status
      t.boolean :report_sent_status

      t.timestamps
    end
  end
end
