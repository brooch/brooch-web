require 'spec_helper'

describe V1::SessionsController do
  describe 'POST /v1/signin' do
    context 'when a user successfully sign in' do
      let(:user) { create(:user)  }
      before {
        post :create, {
          email:    user.email,
          password: user.password,
        }
      }

      it { expect(response.code).to be == '200' }
      it { expect(assigns(:user).api_token).not_to be == user.api_token }
    end

    context 'when a user can not successfully sign in' do
      context 'invalid email' do
        let(:user) { create(:user) }
        before {
          post :create, {
            email:    'invalid email',
            password: user.password,
          }
        }

        it { expect(response.code).to be == '400' }
      end

      context 'invalid password' do
        let(:user) { create(:user) }
        before {
          post :create, {
            email:    user.email,
            password: 'invalid password',
          }
        }

        it { expect(response.code).to be == '400' }
      end
    end
  end
end
