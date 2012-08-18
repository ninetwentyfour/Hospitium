require 'spec_helper'

describe SecPass do
  before :each do
    @user_password = "this_is_a_password"
  end
  
  describe 'Encrypting Password' do
    it 'encrypt the password' do
      @pass = SecPass::encrypt(@user_password)
      @pass.should_not == @user_password
    end
  end
  
  describe 'Decrypting Password' do
    it 'decrypt the password' do
      @enc_pass = SecPass::encrypt(@user_password)
      @pass = SecPass::decrypt(@enc_pass)
      @pass.should == @user_password
    end
  end

end