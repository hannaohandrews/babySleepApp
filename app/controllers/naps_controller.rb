class NapsController < ApplicationController
  def index
    @naps = Nap.all
  end

  def show
    @nap = Nap.find(params[:id])
    @calculated_schedule = @nap.calculated_schedule

    if @nap.calculated_schedule.present?
      # Parse the calculated_schedule JSON string into a hash
      calculated_schedule_hash = JSON.parse(@nap.calculated_schedule)
      # Convert the time strings to DateTime objects if they are present
      calculated_schedule_hash["nap1"] = DateTime.parse(calculated_schedule_hash["nap1"]) if calculated_schedule_hash["nap1"].present?
      calculated_schedule_hash["nap2"] = DateTime.parse(calculated_schedule_hash["nap2"]) if calculated_schedule_hash["nap2"].present?

      # Assign the parsed values to instance variables for use in the view
      @nap.awake_window = calculated_schedule_hash["awake_window"]
      @nap.nap1 = calculated_schedule_hash["nap1"]
      @nap.nap2 = calculated_schedule_hash["nap2"]

      # nap_duration is a string, so no need to convert it
      @nap_duration = calculated_schedule_hash["nap_duration"]
    end
  end

  def new
    @nap = Nap.new
  end

  def create
    @nap = Nap.new(nap_params)

    if @nap.save
      # Flash a success message
      flash[:success] = "Nap schedule created successfully!"
      redirect_to calculate_schedule_path(id: @nap.id)
    else
      render "new"
    end
  end

  def calculate_schedule
    @nap = Nap.find(params[:id])

    if @nap.valid?
      # Calculate the nap schedule
      naps_calculated
      # Calculate the nap duration
      naps_duration_calculation
      puts 'nap duration', @naps_duration
      if @nap.save
        puts "Nap saved successfully"
      else
        puts "Nap save failed with errors: #{nap.errors.full_messages}"
      end

      # Assign the calculated values to instance variables for use in the view
      @calculated_schedule = {
        awake_window: @awake_window,
        nap1: @nap1,
        nap2: @nap2,
        nap_duration: @nap_duration 
      }
      render "result"
    else
      puts "Validation Errors: #{nap.errors.full_messages}"
      render "new"
    end
  end

  def save_result
    saved_schedule = params[:result_data]
    @nap = Nap.find(params[:nap_id])

    if @nap.update(calculated_schedule: saved_schedule)
      flash[:success] = "Nap result saved successfully!"
     # Redirect to the home page (or any other path you want)
     redirect_to root_path
    else
      flash[:error] = "Error saving Nap result."
      render "result" # Render the result view again if there's an error
    end
  end
end

  private
  def nap_params
    params.require(:nap).permit(:title,:date,:age, :wake_up_time,:bedtime)
  end

  def naps_calculated
    if @nap.age == 1
      awake_window = 1.hours
    elsif @nap.age == 2 || @nap.age == 3
      awake_window = 1.5.hours
    elsif @nap.age == 4
      awake_window = 2.hours
    elsif @nap.age == 5
      awake_window = 2.5.hours
    elsif @nap.age == 6
      awake_window = 3.hours
    elsif @nap.age == 7
      awake_window = 3.5.hours
    elsif @nap.age == 8
      awake_window = 4.hours
    elsif @nap.age <= 9 && @nap.age >= 12
      awake_window = 4.5.hours
    elsif @nap.age <= 13 && @nap.age >= 24
      awake_window = 5.hours
    end

    @awake_window = awake_window
    @nap1 = @nap.wake_up_time + awake_window
    @nap2 = @nap1 + awake_window
  end

  def naps_duration_calculation
    if @nap.age == 1
      nap_duration = '15 min to 4 hours'
    elsif @nap.age <= 2 && @nap.age >= 5
      nap_duration = '30 min to 2 hours'
    elsif @nap.age <= 6 && @nap.age >= 7
      nap_duration = '45 min to 2 hours'
    elsif @nap.age <= 8 && @nap.age >= 12
      nap_duration = '1 to 2 hours'
    elsif @nap.age <= 13 && @nap.age >= 24
      nap_duration = '1 to 3 hours'
    end

    @nap_duration = nap_duration
    puts 'HERE NAP DURATION', @nap_duration
  end
