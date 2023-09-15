class RemoveColumnFromNap < ActiveRecord::Migration[7.0]
  def change
    remove_column :naps, :awake_window, :integer
  end
end
