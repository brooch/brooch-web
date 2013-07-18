require 'spec_helper'

describe PostWithMetadata do
  describe '#initialize' do
    context 'validation' do
      context 'post' do
        context 'when invalid' do
          context 'empty text' do
            let(:user)     { create(:user)          }
            let(:new_post) { build(:post, text: '') }
            let(:new_tag)  { build(:tag)            }

            subject {
              PostWithMetadata.new(
                user: user,
                text: new_post.text,
                tags: [new_tag.name],
              )
            }

            it { should be_invalid }
            it { expect(subject.errors[:text]).not_to be_nil }
          end
        end

        context 'valid' do
          context 'valid string' do
            let(:user)     { create(:user) }
            let(:new_post) { build(:post)  }
            let(:new_tag)  { build(:tag)   }

            subject {
              PostWithMetadata.new(
                user: user,
                text: new_post.text,
                tags: [new_tag.name],
              )
            }

            it { should be_valid }
            it { expect(subject.errors[:text]).to be_nil }
          end
        end
      end

      context 'tag' do
        context 'when invalid' do
          context 'empty tag' do
            let(:user)     { create(:user)         }
            let(:new_post) { build(:post)          }
            let(:new_tag)  { build(:tag, name: '') }

            subject {
              PostWithMetadata.new(
                user: user,
                text: new_post.text,
                tags: [new_tag.name],
              )
            }

            it { should be_invalid }
            it { expect(subject.errors[:tags]).not_to be_nil }
          end
        end

        context 'valid' do
          context 'valid string' do
            let(:user)     { create(:user) }
            let(:new_post) { build(:post)  }
            let(:new_tag)  { build(:tag)   }

            subject {
              PostWithMetadata.new(
                user: user,
                text: new_post.text,
                tags: [new_tag.name],
              )
            }

            it { should be_valid }
            it { expect(subject.errors[:tags]).to be_nil }
          end
        end
      end

      context 'author' do
        context 'when invalid' do
          context 'empty name' do
            let(:user)       { create(:user)            }
            let(:new_post)   { build(:post)             }
            let(:new_author) { build(:author, name: '') }

            subject {
              PostWithMetadata.new(
                user:   user,
                text:   new_post.text,
                author: new_author.name,
              )
            }

            it { should be_invalid }
            it { expect(subject.errors[:author]).not_to be_nil }
          end
        end

        context 'valid' do
          context 'valid string' do
            let(:user)       { create(:user)  }
            let(:new_post)   { build(:post)   }
            let(:new_author) { build(:author) }

            subject {
              PostWithMetadata.new(
                user:   user,
                text:   new_post.text,
                author: new_author.name,
              )
            }

            it { should be_valid }
            it { expect(subject.errors[:author]).to be_nil }
          end
        end
      end
    end
  end
end