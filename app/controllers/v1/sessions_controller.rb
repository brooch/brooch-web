module V1
  class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:email])
      @user = @user && @user.authenticate(params[:password])

      if @user
        sign_in(@user)
        render json: @user.to_json(except: [:password_digest])
      else
        # TODO: i18n
        render json: {
          sign_in_error: ['パスワードまたはメールアドレスが正しくありません']
        }, status: 400
      end
    end

    def destroy
      @user = current_user

      if @user
        sign_out(@user)
        render json: @user.to_json(except: [:password_digest])
      else
        # TODO: i18n
        render json: {
          sign_in_error: ['APIトークンが正しくありません']
        }, status: 400
      end
    end
  end
end
