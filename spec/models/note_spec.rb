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
    let(:note) { FactoryGirl.create(:note) }
    
    it "generates a uuid on creation" do
      note.uuid.should_not be_nil
    end
  end
end
