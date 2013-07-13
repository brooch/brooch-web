require 'spec_helper'

describe V1::UsersController do
  describe 'POST /v1/users' do
    context 'when a user is successfully created' do
      before {
        user = build(:user)
        post :create, {
          name:                  user.name,
          email:                 user.email,
          password:              user.password,
          password_confirmation: user.password_confirmation,
        }
      }

      it { expect(response.code).to be == '200' }
    end

    context 'when a user is not successfully created' do
      before {
        user = build(:user)
        post :create, {
          name:                  user.name,
          email:                 user.email,
          password:              user.password,
          password_confirmation: 'no same password',
        }
      }

      it { expect(response.code).to be == '400' }
    end
  end
end
