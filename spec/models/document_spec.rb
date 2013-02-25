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
  
  describe 'protected attributes' do
    
    it 'should deny mass-assignment to the uuid' do
      @document.update_attributes(:uuid =>  "test_uuid")
      @document.uuid.should_not == "test_uuid"
    end
    
    it 'should deny mass-assignment to the id' do
      @document.update_attributes(:id =>  100000)
      @document.id.should_not == 100000
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
