class ProfilesController < ApplicationController
	def index
		@profiles = Profile.all
	end
	
	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(profile_params)

		if @profile.save
			flash[:success] = 'Profile created successfully.'
			#GET /profiles/:id (profile show page)
			redirect_to profile_path(@profile)
		else
			render 'new'
		end
	end

	def show
		@profile = Profile.find(params[:id])
	end

	def edit
		@profile = Profile.find(params[:id])
	end

	private
	def profile_params
		params.require(:profile).permit(:name, :age)
	end
end
