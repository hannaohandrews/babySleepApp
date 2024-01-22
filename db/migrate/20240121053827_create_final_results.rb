class CreateFinalResults < ActiveRecord::Migration[7.0]
  def change
    create_table :final_results do |t|
      t.time :wake_up_time
      t.time :bedtime
      t.time :nap1
      t.time :nap2
      t.time :nap3
      t.time :nap4
      t.time :nap5
      t.integer :awake_window
      t.timestamps
    end
  end
end
