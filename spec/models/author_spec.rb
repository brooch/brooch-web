require 'spec_helper'

describe Author do
  describe 'name' do
    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:author, name: '')
          }

          it { should be_invalid }
        end

        context 'too long' do
          subject {
            build(:author, name: 'x' * 51)
          }

          it { should be_invalid }
        end

        context 'duplicated' do
          subject {
            author = create(:author)
            build(:author, name: author.name)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:author, name: 'test')
          }

          it { should be_valid }
        end
      end
    end
  end
end
