class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string  :acc
      t.date    :start_date
      t.date    :deadline
      t.string  :salesman
      t.integer :salesman_id
      t.date    :samples_received_date
      t.string  :samples_received_by
      t.integer :marketing_id
      t.date    :experiments_done_date
      t.string  :experiments_done_by
      t.integer :experimenter_id
      t.date    :analysis_done_date
      t.string  :analysis_done_by
      t.integer :bioinformatician_id
      t.date    :report_sent_date
      t.string  :report_sent_by

      t.timestamps
    end
  end
end
