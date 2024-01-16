class ChangeCalculations < ActiveRecord::Migration[7.0]
  def change
    add_reference :calculations, :nap, foreign_key: true
  end
end
