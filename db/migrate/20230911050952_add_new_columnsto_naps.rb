# frozen_string_literal: true

class AddNewColumnstoNaps < ActiveRecord::Migration[7.0]
  def change
    add_column :naps, :nap1, :time
    add_column :naps, :nap2, :time
    add_column :naps, :nap3, :time
    add_column :naps, :nap4, :time
    add_column :naps, :nap5, :time
    add_column :naps, :awake_window, :time
  end
end
