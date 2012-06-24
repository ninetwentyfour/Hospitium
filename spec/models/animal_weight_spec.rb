require 'spec_helper'

describe AnimalWeight do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
    it{should belong_to(:animal)}
  
  end

  describe "validations" do
    it{should validate_presence_of(:animal_id)}
    it{should validate_presence_of(:weight)}
    it{should validate_presence_of(:date_of_weight)}
    it{should validate_presence_of(:organization_id)}
  end
  
  
  describe "#create_uuid" do
    let(:animal_weight) { FactoryGirl.create(:animal_weight) }
    
    it "generates a uuid on creation" do
      animal_weight.uuid.should_not be_nil
    end
  end
  
  describe "#formatted_weight_date" do
    let(:animal_weight) { FactoryGirl.create(:animal_weight, @attr.merge(:date_of_weight => "2001-10-20 00:50:22")) }
    
    it "should format weight date" do
      weight_date = Time.parse("2001-10-20 00:50:22").strftime("%a, %b %e at %l:%M")
      animal_weight.formatted_weight_date.should eql(weight_date)
    end
    
    it "should return empty string if nil" do
      animal_weight.date_of_weight = nil
      animal_weight.formatted_weight_date.should eql("")
    end
  end

  describe 'protected attributes' do
    let(:animal_weight) { FactoryGirl.create(:animal_weight) }
    
    it 'should deny mass-assignment to the organization_id' do
      animal_weight.update_attributes(:organization_id =>  10000)
      animal_weight.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the uuid' do
      animal_weight.update_attributes(:uuid =>  "test_uuid")
      animal_weight.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      animal_weight.update_attributes(:id =>  100000)
      animal_weight.id.should_not == 100000
    end
  end

  
end