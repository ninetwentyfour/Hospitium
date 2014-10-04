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

  describe "#show_weight_label_method" do
    let(:animal_weight) { FactoryGirl.create(:animal_weight) }
    
    it "should return the weight as a string" do
      animal_weight.show_weight_label_method.should == "#{animal_weight.weight}"
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

  describe "comma" do
    it "should return a csv for the object" do
      @animal_weight = FactoryGirl.build(:animal_weight)
      @animal_weight.to_comma.should_not be_blank
    end
  end 
end