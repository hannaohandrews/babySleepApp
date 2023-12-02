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

	def update
		@profile = Profile.find(params[:id])
		if @profile.update(profile_params)
			flash[:success] = 'Profile updated successfully'
			redirect_to profile_path(@profile)
		else
			render 'edit'
		end
	end

	def destroy
		@profile = Profile.find(params[:id])
		@profile.naps.destroy_all
		@profile.destroy

		flash[:success] = 'Profile deleted successfully!'
		redirect_to root_path
	end

	private
	def profile_params
		params.require(:profile).permit(:name, :age)
	end
end
