# frozen_string_literal: true
class NapsController < ApplicationController
  before_action :find_profile, only: [:index, :new, :create, :show, :edit, :update, :destroy, :calculate_schedule, :save_result]

  def index
    @naps = @profile.naps
  end

  def new
    @nap = @profile.naps.build
  end

  def create
    @nap = @profile.naps.build(nap_params)
  
    if @nap.save
      # Flash a success message
      flash[:success] = 'Nap schedule created successfully!'
      redirect_to calculate_schedule_profile_nap_path(profile_id: @profile.id, id: @nap.id)
    else
      render 'new'
    end
  end

  def show
    @nap = @profile.naps.find(params[:id])
    @nap_calculation = Calculation.find_by(nap_id: @nap.id)

    # Convert the time strings to DateTime objects if they are present
    # if nap_calculation_hash['nap1'].present?
    #   nap_calculation_hash['nap1'] =
    #     DateTime.parse(nap_calculation_hash['nap1'])
    # end
    # if nap_calculation_hash['nap2'].present?
    #   nap_calculation_hash['nap2'] =
    #     DateTime.parse(nap_calculation_hash['nap2'])
    # end
    if @nap_calculation
      # Assign the parsed values to instance variables for use in the view
      @nap.awake_window = @nap_calculation.awake_window
      @nap.nap1 = @nap_calculation.nap1
      @nap.nap2 = @nap_calculation.nap2
      @nap.nap3 = @nap_calculation.nap3
      @nap.nap4 = @nap_calculation.nap4

      # NEED TO DO LOGIC 
      # if the last nap of the day is less than awake_window time away from bedtime, do not include the last nap 
      # or if want to include the last nap, then delay the bedtime by the awake window

      # nap_duration is a string, so no need to convert it
      @nap_duration = @nap_calculation.nap_duration
    else 
      puts 'NO CALCULATIONS'
    end
  end

  def calculate_schedule
    @nap = @profile.naps.find(params[:id])
    @nap_calculation = Calculation.find_by(nap_id: @nap.id)

    if @nap.valid?
      # Calculate the nap schedule
      naps_calculated
      # Calculate the nap duration
      naps_duration_calculation

      if @nap.save
        puts 'Nap saved successfully'
      else
        puts "Nap save failed with errors: #{@nap.errors.full_messages}"
      end

      if @nap_calculation
        #update the exisitng schedule
        @nap_calculati on.update(
        nap1: @nap1,
        nap2: @nap2,
        nap3: @nap3,
        nap4: @nap4,
        awake_window: @awake_window,
        nap_duration: @nap_duration)
      else
        @nap_calculation = Calculation.create(
        nap1: @nap1,
        nap2: @nap2,
        nap3: @nap3,
        nap4: @nap4,
        awake_window: @awake_window,
        nap_duration: @nap_duration)
      end
      
      render 'result'
    else 
      puts "Validation Errors: #{@nap.errors.full_messages}"
      render 'new'
    end
  end

  def edit
    @nap = @profile.naps.find(params[:id])
  end

  def update
    @nap = @profile.naps.find(params[:id])

    if @nap.update(nap_params)
      flash[:success] = 'Nap schedule updated successfully!'
      redirect_to calculate_schedule_profile_nap_path(profile_id: @profile.id, id: @nap.id)
    else
      render 'edit'
    end
  end

  def save_result
    @nap = @profile.naps.find(params[:id])
    saved_schedule = params[:result_data]

    if @nap.update(nap_calculation: saved_schedule)
      flash[:success] = 'Nap result saved successfully!'
      # Redirect to the home page (or any other path you want)
      redirect_to profile_naps_path(@profile)
    else
      flash[:error] = 'Error saving Nap result.'
      render 'result' # Render the result view again if there's an error
    end
  end

  def destroy
    @nap = @profile.naps.find(params[:id])
    @nap.destroy

    flash[:success] = 'Nap schedule deleted successfully!'
    redirect_to profile_naps_path(@profile)
  end
end


private

def nap_params
  params.require(:nap).permit(:title, :date, :age, :wake_up_time, :bedtime)
end

def find_profile
  @profile = Profile.find(params[:profile_id])
end

def naps_calculated
  @nap = @profile.naps.find(params[:id])

  if @nap.age == 1
    awake_window = 1
  elsif @nap.age == 2 || @nap.age == 3
    awake_window = 1.5
  elsif @nap.age == 4
    awake_window = 2
  elsif @nap.age == 5
    awake_window = 2.5
  elsif @nap.age == 6
    awake_window = 3
  elsif @nap.age == 7
    awake_window = 3.5
  elsif @nap.age == 8
    awake_window = 4
  elsif @nap.age >= 9 && @nap.age <= 12
    awake_window = 4.5
  elsif @nap.age >= 13 && @nap.age <= 24
    awake_window = 5
  end

  @awake_window = awake_window
  @nap1 = @nap.wake_up_time + awake_window.hours
  @nap2 = @nap1 + awake_window.hours
  @nap3 = @nap2 + awake_window.hours
  @nap4 = @nap3 + awake_window.hours
end

def naps_duration_calculation
  @nap = @profile.naps.find(params[:id])

  if @nap.age == 1
    nap_duration = '15 min to 4 hours'
  elsif @nap.age >= 2 && @nap.age <= 5
    nap_duration = '30 min to 2 hours'
  elsif @nap.age >= 6 && @nap.age <= 7
    nap_duration = '45 min to 2 hours'
  elsif @nap.age >= 8 && @nap.age <= 12
    nap_duration = '1 to 2 hours'
  elsif @nap.age >= 13 && @nap.age <= 24
    nap_duration = '1 to 3 hours'
  end

  @nap_duration = nap_duration
end
