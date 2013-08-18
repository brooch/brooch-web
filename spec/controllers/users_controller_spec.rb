require 'spec_helper'

describe V1::UsersController do
  describe 'POST /v1/users' do
    context 'when a user is successfully created' do
      before {
        user = build(:user)
        post :create, {
          name:     user.name,
          email:    user.email,
          password: user.password,
        }
      }

      it { expect(response.code).to be == '200' }
    end

    context 'when a user is not successfully created' do
      context 'validation error' do
        before {
          user = build(:user)
          post :create, {
            name:     user.name,
            email:    'invalid string',
            password: user.password,
          }
        }

        it { expect(response.code).to be == '400' }
      end

      context 'already logged in' do
        before {
          user     = create(:user)
          new_user = build(:user)
          post :create, {
            name:      new_user.name,
            email:     new_user.email,
            password:  new_user.password,
            api_token: user.api_token,
          }
        }

        it { expect(response.code).to be == '400' }
      end
    end
  end
end
