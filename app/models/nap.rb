class Nap < ApplicationRecord
validates :title, presence: true
validates :date, presence: true
validates :age, presence: true, numericality: { only_integer: true }
validates :wake_up_time, presence: true
validates :bedtime, presence: true

attr_accessor :nap1, :nap2, :nap3, :nap4, :nap5, :awake_window
end
