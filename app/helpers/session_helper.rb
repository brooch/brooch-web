module SessionHelper
  def sign_in(user)
    api_token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
    user.update_attributes(api_token: api_token)
  end

  def sign_out(user)
    user.update_attributes(api_token: nil)
  end

  def signed_in?
    !!current_user
  end

  def current_user
    return unless params[:api_token]
    @current_user ||= User.find_by_api_token(params[:api_token])
  end
end
