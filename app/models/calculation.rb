# frozen_string_literal: true
class Calculation < ApplicationRecord
  belongs_to :nap, class_name: 'Nap'
  has_one :final_result, dependent: :destroy
end
