class YosController < ApplicationController
  def create
    if @user = User.find_by(name: yo_params[:to]) then
      @yo = @user.yos.create(user_id: 0, to_id: @user.id)
      render :no_such_user, status: :created
    else
      render :no_such_user, status: :not_found
    end
  end

  private
  def yo_params
    params.permit(:to)
  end
end
