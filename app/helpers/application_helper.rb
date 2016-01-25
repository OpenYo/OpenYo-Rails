module ApplicationHelper
  def password_current_user
    return @pass_current_user if @pass_current_user
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      @user = user
    else
      false
    end
  end
end
