require 'spec_helper'

describe Event do
  before(:each) do
    @event = FactoryGirl.create(:event)
    
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:animal)}
  end
  
  describe 'protected attributes' do
    
    it 'should deny mass-assignment to the id' do
      @event.update_attributes(:id =>  100000)
      @event.id.should_not == 100000
    end
  end
  
  describe "record_event" do
    it "should create a new general note" do
      event_hash = { :type => "Test Event", 
                     :message => "Test Message", 
                     :organization => @event.animal.organization_id, 
                     :uuid => @event.animal.uuid, 
                     :animal => @event.animal.id 
                   }
      time1 = Time.now
      event = Event.record_event(event_hash)
      time2 = Time.now
      event.created_at.should be_between(time1, time2)
    end
  end
end
