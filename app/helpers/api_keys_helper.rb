module ApiKeysHelper
  def current_user
    # トークンを検索
    token = ApiKey.find_by(access_token: request.headers["X-API-TOKEN"])

    if token && !token.expired?
      @current_user = User.find(token.user_id)
    else
      false
    end
  end
end
