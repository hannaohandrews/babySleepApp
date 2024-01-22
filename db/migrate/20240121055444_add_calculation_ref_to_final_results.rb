class AddCalculationRefToFinalResults < ActiveRecord::Migration[7.0]
  def change
    add_reference :final_results, :calculation, null: false, foreign_key: true
  end
end
