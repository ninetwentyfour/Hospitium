# this is used to encrypt and decrypt third party passwords that we store. not super safe, but better than plain text
module SecPass
  class << self
    def encrypt(pass)
      Base64.encode64(Encryptor.encrypt(:value => pass, :key => ENV['SALTY'])).encode('utf-8')
    end
    
    def decrypt(pass)
      begin
        decoded = Base64.decode64(pass.encode('ascii-8bit'))
        Encryptor.decrypt(:value => decoded, :key => ENV['SALTY'])
      rescue Exception => exception
        return false
      end
    end
  end
end