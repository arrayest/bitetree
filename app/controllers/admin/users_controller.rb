class Admin::UsersController < AdminApplicationController
  before_action :set_user, only: [:profile, :password, :update_profile, :update_password]

  def index
    @users = User.all.page(params[:page]).per(15)
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
  def set_user
    @user = current_user
  end
end
