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

  
end