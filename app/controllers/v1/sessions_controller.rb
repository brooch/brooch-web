#encoding: utf-8

module V1
  class SessionsController < ApplicationController
    before_action :require_guest, only: [:create]
    before_action :require_user,  only: [:destroy]

    def create
      @user = User.find_by_email(params[:email]) ||
              User.find_by_name(params[:email]) # nameでも探してみる
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

      sign_out(@user)
      render json: @user.to_json(except: [:password_digest])
    end
  end
end
