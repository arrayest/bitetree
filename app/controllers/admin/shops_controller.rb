class Admin::ShopsController < AdminApplicationController
  before_action :set_shop, only: [:show, :edit, :update]

  def index
    @q = Shop.ransack(params[:q])
    @shops= @q.result.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    @shop.update(shop_params)
    redirect_to admin_shop_path(@shop)
  end

  private
  def shop_params
    params.require(:shop).permit(:name, :photo, :hotline, :area, :address, :description)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
