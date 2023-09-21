class ChangeAwakeWindowDataTypeInNaps < ActiveRecord::Migration[6.0]
  def change
    change_column :naps, :awake_window, :decimal, precision: 5, scale: 2
  end
end
