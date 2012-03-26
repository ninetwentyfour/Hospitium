require 'spec_helper'

describe Note do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:animal)}
    it{should belong_to(:user)}
  end
  
  describe "#create_uuid" do
    let(:note) { Factory(:note) }
    
    it "generates a uuid on creation" do
      note.uuid.should_not be_nil
    end
  end
  
  describe 'protected attributes' do
    let(:note) { Factory(:note) }
    
    it 'should deny mass-assignment to the user_id' do
      note.update_attributes(:user_id =>  10)
      note.user_id.should_not == 10
    end
    
    it 'should deny mass-assignment to the uuid' do
      note.update_attributes(:uuid =>  "test_uuid")
      note.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      note.update_attributes(:id =>  100000)
      note.id.should_not == 100000
    end
  end
end
