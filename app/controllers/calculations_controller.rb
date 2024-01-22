# frozen_string_literal: true
class CalculationsController < ApplicationController
	before_action :find_nap

	def index
		@calculations = Calculation.all
	end
	
	def new
		@calculation = Calculation.new
	end

	def create
		@calculation = Calculation.new(calculation_params)

		if @calculation.save
			flash[:success] = "Calculation saved successfully"
		else
			render 'new'
		end

	end

	private 

	def calculation_params
		params.require(:calculation).permit(:nap1,:nap2,:nap3,:nap4,:awake_window, :nap_duration,:nap_id)
	end

	def find_nap
		@calculation = Calculation.find(params[:nap_id])
	end
end
