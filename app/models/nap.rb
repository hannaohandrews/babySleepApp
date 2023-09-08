class Nap < ApplicationRecord
has_many :calculations

validates :title, presence: true
validates :date, presence: true
validates :age, presence: true, numericality: { only_integer: true }
validates :wake_up_time, presence: true
validates :bedtime, presence: true
end
