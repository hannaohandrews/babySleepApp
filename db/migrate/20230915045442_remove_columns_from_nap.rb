# frozen_string_literal: true

class RemoveColumnsFromNap < ActiveRecord::Migration[7.0]
  def change
    remove_column :naps, :nap1, :time
    remove_column :naps, :nap2, :time
    remove_column :naps, :nap3, :time
    remove_column :naps, :nap4, :time
    remove_column :naps, :nap5, :time
    remove_column :naps, :awake_window, :integer
  end
end
