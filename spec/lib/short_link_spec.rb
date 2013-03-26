require 'spec_helper'

describe ShortLink do
  before :each do
    @link = "https://hospitium.co"
  end
  
  describe '#shorten_link' do
    it 'should return link' do
      VCR.use_cassette('lib/shorten_link_success') do
        @short_link = ShortLink.shorten_link(@link)
      end
      @short_link.should == "http://bit.ly/X8L44h"
    end
  end

end