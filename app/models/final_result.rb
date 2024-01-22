# frozen_string_literal: true

class FinalResult < ApplicationRecord
	belongs_to :calculation, class_name: 'Calculation'
end
