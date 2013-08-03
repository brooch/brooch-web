#encoding: utf-8

class RootController < ApplicationController
  def index
    redirect_to 'http://brooch.mobi/'
  end
end
