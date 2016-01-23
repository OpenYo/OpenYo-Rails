class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include ApiKeysHelper
  include ApplicationHelper

  private
  def token_auth
    unless current_user then
      render :authentication_required, status: :unauthorized
      return false
    end
  end

  def password_auth
    unless password_current_user then
      render :authentication_required, status: :unauthorized
      return false
    end
  end
end
