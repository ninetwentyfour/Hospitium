require 'spec_helper'

describe ShortLink do
  before :each do
    @my_link = 'https://hospitium.co'
  end
  
  describe '#shorten_link' do
    it 'should return link' do
      VCR.use_cassette('lib/shorten_link_success', :match_requests_on => [:host]) do
        @short_link = ShortLink.shorten_link(@my_link)
      end
      expect(@short_link).to eq 'http://bit.ly/X8L44h'
    end
  end
end
