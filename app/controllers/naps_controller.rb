class NapsController < ApplicationController
  def index
    @naps = Nap.all
  end
  
  def show
    @nap = Nap.find(params[:id])
  
    if @nap.calculated_schedule.present?
      # Parse the calculated_schedule JSON string into a hash
      calculated_schedule_hash = JSON.parse(@nap.calculated_schedule)
  
      # Convert the time strings to DateTime objects if they are present
      calculated_schedule_hash["nap1"] = DateTime.parse(calculated_schedule_hash["nap1"]) if calculated_schedule_hash["nap1"].present?
      calculated_schedule_hash["nap2"] = DateTime.parse(calculated_schedule_hash["nap2"]) if calculated_schedule_hash["nap2"].present?
  
      # Assign the parsed values to instance variables for use in the view
      @awake_window = calculated_schedule_hash["awake_window"]
      @nap1 = calculated_schedule_hash["nap1"]
      @nap2 = calculated_schedule_hash["nap2"]
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
      puts 'HERE NAP VALID?'
      naps_calculated

      @nap.nap1 = @nap1
      @nap.nap2 = @nap2
      @nap.awake_window = @awake_window

      if @nap.save
        puts "Nap saved successfully"
      else
        puts "Nap save failed with errors: #{nap.errors.full_messages}"
      end
      @calculated_schedule = {
        title: @nap.title,
        date: @nap.date,
        age: @nap.age,
        wake_up_time: @nap.wake_up_time,
        bedtime: @nap.bedtime,
        awake_window: @awake_window,
        nap1: @nap.nap1,
        nap2: @nap.nap2
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
    params.require(:nap).permit(:title,:date,:age, :wake_up_time,:bedtime, :awake_window,:nap1, :nap2)
  end

  def naps_calculated
    puts 'HERE NAPS CALCULATED'
    awake_window = 3.hours
    @awake_window = awake_window
    @nap1 = @nap.wake_up_time + awake_window
    @nap2 = @nap1 + awake_window
  end
