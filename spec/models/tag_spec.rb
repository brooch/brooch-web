require 'spec_helper'

describe Tag do
  describe 'name' do
    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:tag, name: '')
          }

          it { should be_invalid }
        end

        context 'too long' do
          subject {
            build(:tag, name: 'x' * 21)
          }

          it { should be_invalid }
        end

        context 'duplicated' do
          subject {
            tag = create(:tag)
            build(:tag, name: tag.name)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:tag, name: 'test')
          }

          it { should be_valid }
        end
      end
    end
  end
end
