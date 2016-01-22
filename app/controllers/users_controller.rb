class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(name: params[:name])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :creation_success, status: :created
    else
      render :creation_fail, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
