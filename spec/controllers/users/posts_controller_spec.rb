require 'spec_helper'

describe V1::Users::PostsController do
  describe 'GET /v1/users/posts' do
    context 'unauthorized request' do
      let(:user) { create(:user) }
      before {
        get :index, {
          user_id: user.id,
        }
      }

      it { expect(response.code).to be == '403' }
    end

    context 'authorized request' do
      let(:new_post) { build(:post) }

      before {
        user       = create(:user)
        new_tag    = build(:tag)
        new_author = build(:author)

        PostWithMetadata.create(
          user:     user,
          text:     new_post.text,
          image_id: new_post.image_id,
          tags:     [new_tag.name],
          author:   new_author.name,
        )

        get :index, {
          user_id:   user.id,
          api_token: user.api_token,
        }
      }

      it { expect(response.code).to be == '200' }
      it {
        result = JSON.load(response.body)
        expect(result.first['text']).to be == new_post.text
      }
    end
  end

  describe 'POST /v1/users/:id/posts' do
    context 'when a post is successfully created' do
      before {
        user       = create(:user)
        new_post   = build(:post)
        new_tag    = build(:tag)
        new_author = build(:author)

        post :create, {
          user_id:   user.id,
          text:      new_post.text,
          image_id:  new_post.image_id,
          tags:      [new_tag.name],
          author:    new_author.name,
          api_token: user.api_token,
        }
      }

      it { expect(response.code).to be == '200' }
    end

    context 'when a user is not successfully created' do
      context 'unauthorized request' do
        let(:user) { create(:user) }
        before {
          post :create, {
            user_id: user.id,
          }
        }

        it { expect(response.code).to be == '403' }
      end

      context 'authorized request' do
        before {
          user       = create(:user)
          new_post   = build(:post, text: '')
          new_tag    = build(:tag)
          new_author = build(:author)

          post :create, {
            user_id:   user.id,
            text:      new_post.text,
            image_id:  new_post.image_id,
            tags:      [new_tag.name],
            author:    new_author.name,
            api_token: user.api_token,
          }
        }

        it { expect(response.code).to be == '400' }
        it { expect(response.body).to be =~ /can't be blank/ }
      end
    end
  end

  describe 'DELETE /v1/users/:id/posts/:id' do
    context 'when a post is successfully deleted' do
      let(:user) { create(:user) }
      let(:post) { create(:post, user_id: user.id) }

      before {
        delete :destroy, {
          user_id:   user.id,
          id:        post.id,
          api_token: user.api_token,
        }
      }

      it { expect(response.code).to be == '200' }
    end

    context 'when a post is not successfully deleted' do
      context 'unauthorized request (guest)' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user_id: user.id) }

        before {
          delete :destroy, {
            user_id: user.id,
            id:      post.id,
          }
        }

        it { expect(response.code).to be == '403' }
      end

      context 'unauthorized request (not owner)' do
        let(:user)  { create(:user) }
        let(:other) { create(:user) }
        let(:post)  { create(:post, user_id: other.id) }

        before {
          delete :destroy, {
            user_id:   user.id,
            id:        post.id,
            api_token: user.api_token
          }
        }

        it { expect(response.code).to be == '403' }
      end
    end
  end
end
