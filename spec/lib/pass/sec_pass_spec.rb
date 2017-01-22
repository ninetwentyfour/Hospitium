require 'spec_helper'

describe SecPass do
  before :each do
    @user_password = 'this_is_a_password'
  end

  describe 'Encrypting Password' do
    it 'encrypt the password' do
      pass = SecPass.encrypt(@user_password)
      expect(pass).to_not eq @user_password
    end
  end

  describe 'Decrypting Password' do
    it 'decrypt the password' do
      enc_pass = SecPass.encrypt(@user_password)
      pass = SecPass.decrypt(enc_pass)
      expect(pass).to eq @user_password
    end
  end
end
