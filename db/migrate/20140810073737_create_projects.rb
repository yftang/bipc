class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string  :acc
      t.date    :start_date
      t.date    :deadline
      t.string  :creater
      t.integer :creater_id
      t.string  :salesman
      t.integer :salesman_id
      t.date    :samples_received_date
      t.string  :samples_receiver
      t.integer :samples_receiver_id
      t.date    :experiments_done_date
      t.string  :experimenter
      t.integer :experimenter_id
      t.date    :analysis_done_date
      t.string  :bioinformatician
      t.integer :bioinformatician_id
      t.date    :report_sent_date
      t.string  :marketing
      t.string  :marketing_id

      t.timestamps
    end
  end
end
