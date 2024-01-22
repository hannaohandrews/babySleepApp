class AddNapDurationToFinalResults < ActiveRecord::Migration[7.0]
  def change
    add_column :final_results, :nap_duration, :string
  end
end
