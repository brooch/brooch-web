require 'spec_helper'

describe User do
  describe 'instance methods' do
    subject {
      build(:user)
    }

    it { should respond_to :name                  }
    it { should respond_to :email                 }
    it { should respond_to :password_digest       }
    it { should respond_to :api_token             }
    it { should respond_to :password              }
    it { should respond_to :password_confirmation }
  end

  describe 'name' do
    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:user, name: '')
          }

          it { should be_invalid }
        end

        context 'too long' do
          subject {
            build(:user, name: 'x' * 51)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:user, name: 'test')
          }

          it { should be_valid }
        end
      end
    end
  end

  describe 'email' do
    context 'before save' do
      context 'when email does not consist of upper-case letters' do
        subject {
          create(:user, email: 'test@example.com')
        }

        it { expect(subject.email).to be == 'test@example.com' }
      end

      context 'when email consists of upper-case letters' do
        subject {
          create(:user, email: 'TEST@EXAMPLE.COM')
        }

        it { expect(subject.email).to be == 'test@example.com' }
      end
    end

    context 'validation' do
      context 'when invalid' do
        context 'empty' do
          subject {
            build(:user, email: '')
          }

          it { should be_invalid }
        end

        context 'invalid string' do
          subject {
            build(:user, email: 'invalid email string')
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'valid string' do
          subject {
            build(:user, email: 'test@example.com')
          }

          it { should be_valid }
        end
      end
    end
  end

  describe 'password' do
    context 'validation' do
      context 'when invalid' do
        context 'not same' do
          subject {
            build(:user, password_confirmation: 'not same password')
          }

          it { should be_invalid }
        end

        context 'too short' do
          subject {
            build(:user, password: 'foo', password_confirmation: 'foo')
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'same password' do
          subject {
            build(:user, password: 'password', password_confirmation: 'password')
          }

          it { should be_valid }
        end
      end
    end
  end

  describe 'api_token' do
    context 'validation' do
      context 'when invalid' do
        context 'too long' do
          subject {
            build(:user, api_token: 'x' * 41)
          }

          it { should be_invalid }
        end
      end

      context 'valid' do
        context 'empty' do
          subject {
            build(:user, api_token: '')
          }

          it { should be_valid }
        end

        context 'valid string' do
          subject {
            build(:user, api_token: Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s))
          }

          it { should be_valid }
        end
      end
    end
  end
end
