# frozen_string_literal: true

class Naps < ActiveRecord::Migration[7.0]
  def change
    change_column :naps, :age, :integer
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
