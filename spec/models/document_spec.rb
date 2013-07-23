require 'spec_helper'

describe Document do
  before(:each) do
    @document = FactoryGirl.create(:document)
    
    @attr = { 

    }
  end
  
  describe "relations" do
    it{should belong_to(:documentable)}
  end
  
  describe "#create_uuid" do
    
    it "generates a uuid on creation" do
      @document.uuid.should_not be_nil
    end
  end
  
  describe "upload image" do
    it {should have_attached_file(:document)}
  end
  
  describe "#not_blacklisted_file" do    
    it "should reject certain file types" do
      @document.document_content_type = "application/exe"
      @document.save.should == false
    end
    
    it "should accept certain file types" do
      @document.document_content_type = "application/pdf"
      @document.save.should == true
    end
  end
end
