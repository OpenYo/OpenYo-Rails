class YosController < ApplicationController
  before_action :auth, only: :create

  def create
    if @user = User.find_by(name: yo_params[:to]) then
      @yo = @user.yos.create(user_id: current_user.id, to_id: @user.id)
      render :sent_yo, status: :created
    else
      render :no_such_user, status: :not_found
    end
  end

  private
  def yo_params
    params.permit(:to)
  end

  def auth
    unless current_user then
      render :authentication_required, status: :unauthorized
      return false
    end
  end
end
