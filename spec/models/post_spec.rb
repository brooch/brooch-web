require 'spec_helper'

describe Post do
  describe 'text' do
    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:post, text: '')
          }

          it { should be_invalid }
        end

        context 'too long' do
          subject {
            build(:post, text: 'x' * 256)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:post, text: 'test')
          }

          it { should be_valid }
        end
      end
    end
  end

  describe '#create_with_metadata' do
    context 'tag' do
      context 'create with a not-existing tag' do
        let(:new_post) { build(:post) }
        let(:new_tag)  { build(:tag)  }

        it {
          expect {
            Post.create_with_metadata(
              text: new_post.text,
              tags: [new_tag.name],
            )
          }.to change {
            Tag.count
          }.by(1)
        }
      end

      context 'create with an existing tag' do
        let(:new_post) { build(:post) }
        let!(:tag)     { create(:tag) }

        it {
          expect {
            Post.create_with_metadata(
              text: new_post.text,
              tags: [tag.name],
            )
          }.to change {
            Tag.count
          }.by(0)
        }
      end
    end

    context 'author' do
      context 'create with a not-existing author' do
        let(:new_post)   { build(:post)   }
        let(:new_author) { build(:author) }

        it {
          expect {
            Post.create_with_metadata(
              text:   new_post.text,
              author: new_author.name,
            )
          }.to change {
            Author.count
          }.by(1)
        }
      end

      context 'create with an existing tag' do
        let(:new_post) { build(:post)    }
        let!(:author)  { create(:author) }

        it {
          expect {
            Post.create_with_metadata(
              text:   new_post.text,
              author: author.name,
            )
          }.to change {
            Author.count
          }.by(0)
        }
      end
    end
  end
end
