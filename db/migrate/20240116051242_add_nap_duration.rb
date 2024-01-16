class AddNapDuration < ActiveRecord::Migration[7.0]
  def change
    add_column :calculations, :nap_duration, :string
  end
end
