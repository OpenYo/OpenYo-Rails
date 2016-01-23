module ApplicationHelper
  def password_current_user
    return @pass_current_user if @pass_current_user
    return false if params[:user].nil?
    user = User.find_by(name: params[:user][:name])

    if user && user.authenticate(params[:user][:password])
      @user = user
    else
      false
    end
  end
end
