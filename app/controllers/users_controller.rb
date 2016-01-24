class UsersController < ApplicationController
  before_action :password_auth, only: :create_token
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

  def create_token
    @token = @user.api_keys.create
    render :new_token, status: :created
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
