require 'spec_helper'

describe Status do
  before(:each) do
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:organization)}
  
    it{should have_many(:animals)}
  end

  describe "validations" do
    it{should validate_presence_of(:status)}
    it{should validate_presence_of(:organization_id)}
  end
  
  describe 'protected attributes' do
    let(:status) { FactoryGirl.create(:status) }
    
    it 'should deny mass-assignment to the organization_id' do
      status.update_attributes(:organization_id =>  10000)
      status.organization_id.should_not == 10000
    end
    
    it 'should deny mass-assignment to the id' do
      status.update_attributes(:id =>  100000)
      status.id.should_not == 100000
    end
  end

  
end