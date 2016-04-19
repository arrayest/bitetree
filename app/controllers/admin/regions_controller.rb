class Admin::RegionsController < AdminApplicationController
  before_action :set_city, only: [:show]

  def index
    @q = Province.ransack(params[:q])
    @provinces = @q.result(distinct: true).page(params[:page]).per(34)
  end

  def show
  end

  private
  def set_city
    @city = City.find(params[:id])
  end
end
