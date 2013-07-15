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
end
