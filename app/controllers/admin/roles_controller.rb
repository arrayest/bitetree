class Admin::RolesController < AdminApplicationController
  before_action :set_role, only: [:edit, :update]

  def index
    @q = Role.ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?
    @roles = @q.result.page(params[:page]).per(10)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.create(role_params)
    redirect_to admin_roles_path
  end

  def edit
  end

  def update
    @role.update(role_params)
    redirect_to admin_roles_path
  end

  private
  def role_params
    params.require(:role).permit(:name)
  end

  def set_role
    @role = Role.find(params[:id])
  end
end
