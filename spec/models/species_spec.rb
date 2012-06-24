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
  
  
  describe 'protected attributes' do
    let(:species) { FactoryGirl.create(:species) }
    
    it 'should deny mass-assignment to the organization_id' do
      species.update_attributes(:organization_id =>  10000)
      species.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      species.update_attributes(:uuid =>  "test_uuid")
      species.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      species.update_attributes(:id =>  100000)
      species.id.should_not == 100000
    end
  end

  
end