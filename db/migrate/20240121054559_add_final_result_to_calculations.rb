class AddFinalResultToCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :final_results do |t|
      # Add any other columns you need in the final_results table
      t.references :calculation, foreign_key: true
      t.timestamps
    end
  end
end