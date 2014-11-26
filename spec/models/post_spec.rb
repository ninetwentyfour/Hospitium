require 'spec_helper'

describe Post do
  
  describe "#send_public_tweet" do
    let(:post) { FactoryGirl.create(:post) }
    
  	it 'should return No Object(s) specified for an invalid object' do
      TwitterAccount.stubs(:twitter_post).returns(true)
      ShortLink.stubs(:shorten_link).returns("http://example.com")
      
      expect(post.send_public_tweet).to eq true

      ShortLink.unstub(:shorten_link)
  	end
  end

end