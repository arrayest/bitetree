class Admin::UsersController < AdminApplicationController
  before_action :set_current_user, only: [:profile, :password, :update_profile, :update_password]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @q = User.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
    @users = @q.result.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to admin_user_path(@user)
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  def profile
  end

  def password
  end

  def update_profile
    profile_hash = {nickname: params[:nickname], phone: params[:phone], address: params[:address], avatar: params[:avatar]}
    @user.update(profile_hash)
    redirect_to :back
  end

  def update_password
    if params[:password].eql?(params[:password_confirmation])
      @user.password = params[:password]
      if @user.save
        flash[:update] = '修改密码成功'
      else
        flash[:update] = @user.errors.full_messages.join("\n")
      end
    else
      flash[:update] = '两次输入的密码不一致'
    end
    redirect_to :back
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :nickname, :phone, :address, :avatar)
  end

  def set_current_user
    @user = current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
