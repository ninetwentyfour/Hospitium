require 'spec_helper'

describe Notification do
  
  describe '#send_public_tweet' do
    let(:notification) { FactoryGirl.create(:notification) }
    
  	it 'should return No Object(s) specified for an invalid object' do
      TwitterAccount.stubs(:twitter_post).returns(true)

      expect(notification.send_public_tweet).to eq true
  	end
  end
end
