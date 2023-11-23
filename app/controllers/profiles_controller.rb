class ProfilesController < ApplicationController
	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(profile_params)

		if @profile.save
			redirect_to nap_index_path
		else
			render 'new'
		end
	end


	private
	def profile_params
		params.require(:profile).permit(:name, :age)
	end
end
