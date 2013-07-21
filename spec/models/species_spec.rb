require 'spec_helper'

describe Species do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:name)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:species) { FactoryGirl.create(:species) }
    
    it "generates a uuid on creation" do
      species.uuid.should_not be_nil
    end
  end

  
end