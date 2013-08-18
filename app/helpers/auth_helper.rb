module AuthHelper
  def require_guest
    if signed_in?
      render json: {
        auth_error: ['すでにログインしています']
      }, status: 400
    end
  end

  def require_user
    unless signed_in?
      render json: {
        auth_error: ['ログインが必要です']
      }, status: 400
    end
  end
end
