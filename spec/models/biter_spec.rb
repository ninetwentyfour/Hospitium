require 'spec_helper'

describe Biter do
  
  describe "relations" do
    it{should have_many(:animals)}
  end

  describe "#show_value_label_method" do
    let(:biter) { FactoryGirl.create(:biter) }
    
    it "should return the biter value as a string" do
      biter.show_value_label_method.should == "#{biter.value}"
    end
  end
  
end