# frozen_string_literal: true

class CreateNaps < ActiveRecord::Migration[7.0]
  def change
    create_table :naps do |t|
      t.string :title
      t.date :date
      t.string :age
      t.time :wake_up_time
      t.time :bedtime

      t.timestamps
    end
  end
end
