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
      redirect_to @nap
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def nap_params
    params.require(:nap).permit(:title,:date,:age, :wake_up_time,:bedtime)
  end
end
