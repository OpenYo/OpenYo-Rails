class YosController < ApplicationController
  def create
    @yo = Yo.new(user_params)
  end

  private
  def user_params
    params.require(:yo).permit(:name)
  end
end
