class NapsController < ApplicationController
  def index
    @naps = Nap.all
  end

  def show
    @nap = Nap.find(params[:id])
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
      render "result"
    else
      puts "Validation Errors: #{nap.errors.full_messages}"
      render "new"
    end
  end

  def save_result
    session[:result_data] = params[:result_data]
    redirect_to root_path, notice: "Nap schedule saved successfully!"
  end

  private

  def nap_params
    params.require(:nap).permit(:title,:date,:age, :wake_up_time,:bedtime)
  end

end
