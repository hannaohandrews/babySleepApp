# frozen_string_literal: true

class AddCalculatedScheduleToNaps < ActiveRecord::Migration[7.0]
  def change
    add_column :naps, :calculated_schedule, :text
  end
end
