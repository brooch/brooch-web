require 'spec_helper'

describe RootController do
  describe 'GET /' do
    before { get :index }
    it { expect(response).to redirect_to 'http://brooch.mobi/' }
  end
end
