module ApiKeysHelper
  def current_user
    # トークンを検索
    token = ApiKey.where(access_token: params[:token]).first
    if token && !token.expired?
      @current_user = User.find(token.user_id)
    else
      false
    end
  end
end
