#encoding: utf-8

module V1
  class UsersController < ApplicationController
    before_action :require_guest, only: [:create]

    def create
      @user = User.new(
        name:     params[:name],
        email:    params[:email],
        password: params[:password],
      )

      if @user.save
        sign_in(@user)
        render json: @user.to_json(except: [:password_digest])
      else
        render json: @user.errors.to_json, status: 400
      end
    end
  end
end
