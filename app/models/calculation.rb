# frozen_string_literal: true

class Calculation < ApplicationRecord
  belongs_to :nap
  has_one :final_result
end
