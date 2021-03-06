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

  describe 'image_id' do
    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:post, image_id: nil)
          }

          it { should be_invalid }
        end

        context 'invalid number' do
          subject {
            build(:post, image_id: 9999)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:post, image_id: 1)
          }

          it { should be_valid }
        end
      end
    end
  end
end
