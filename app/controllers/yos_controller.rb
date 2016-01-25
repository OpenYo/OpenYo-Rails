class YosController < ApplicationController
  before_action :token_auth, only: [:create, :history]

  def create
    if @user = User.find_by(name: yo_params[:to]) then
      @yo = @user.yos.create(from_id: @current_user.id)
      @user.become_friends_with(@current_user)
      render :sent_yo, status: :created
    else
      render :no_such_user, status: :not_found
    end
  end

  def history
    limit = params[:limit] || 20
    page = params[:page] || 1
    since = params[:since] || 20.years.ago
    @yos = @current_user.yos.where('created_at >= ?', since).limit(limit).page(page)
  end

  private
  def yo_params
    params.permit(:to)
  end
end
