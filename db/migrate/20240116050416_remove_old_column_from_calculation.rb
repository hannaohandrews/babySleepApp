class RemoveOldColumnFromCalculation < ActiveRecord::Migration[7.0]
  def change
    remove_column :calculations, :wake_up_time, :string
    remove_column :calculations, :time, :string
    remove_column :calculations, :bedtime, :time
  end
end
