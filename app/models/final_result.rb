class FinalResult < ApplicationRecord
	belongs_to :calculation

	attribute :nap_duration, :string
end
