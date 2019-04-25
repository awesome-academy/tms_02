class UsersController < ApplicationController
  before_action :load_user, only: %i(show destroy)

  def index
    @users = User.sort_by_name.page(params[:page]).per Settings.user.index_page
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.user.delete_user"
      redirect_to users_path
    else
      flash[:danger] = t "controller.user.delete_faild"
      redirect_to root_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return @user
    flash[:danger] = t "not_found"
    redirect_to users_path
  end
end
