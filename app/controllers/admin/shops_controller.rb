class Admin::ShopsController < AdminApplicationController
  before_action :set_shop, only: [:show]

  def index
    @q = Shop.ransack(params[:q])
    @shops= @q.result.page(params[:page]).per(10)
  end

  def show
  end

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end
end
