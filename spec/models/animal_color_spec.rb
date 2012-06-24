require 'spec_helper'

describe AnimalColor do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:color)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:animal_color) { FactoryGirl.create(:animal_color) }
    
    it "generates a uuid on creation" do
      animal_color.uuid.should_not be_nil
    end
  end
  
  describe 'protected attributes' do
    let(:animal_color) { FactoryGirl.create(:animal_color) }
    
    it 'should deny mass-assignment to the organization_id' do
      animal_color.update_attributes(:organization_id =>  10000)
      animal_color.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      animal_color.update_attributes(:uuid =>  "test_uuid")
      animal_color.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      animal_color.update_attributes(:id =>  100000)
      animal_color.id.should_not == 100000
    end
  end

  
end