class FinalResultsController < ApplicationController
	before_action :find_final_result, only: [:show,:edit,:update, :destroy]

	def index 
		@final_results = FinalResult.all
	end

	def new
		@final_result = FinalResult.new
	end

	def create
		@final_result = FinalResult.new(final_result_params)

		if @final_result.save
			flash[:success] = "Final Result saved successfully"
			redirect_to final_result_path(@final_result)
		else
			render :new
		end
	end

	private

	def find_final_result
		@final_result = Calculation.find_by(calculation_id: params[:calculation_id])
	end

	def final_result_params
		params.require(:final_result).permit(:nap1, :nap2, :nap3, :nap4, :awake_window, :nap_duration, :calculation_id)
	end
	
end
