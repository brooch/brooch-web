#encoding: utf-8

class ApplicationController < ActionController::Base
  include SessionHelper
  include AuthHelper
end
