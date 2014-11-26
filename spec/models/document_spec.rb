require 'spec_helper'

describe Document do
  before(:each) do
    @document = FactoryGirl.create(:document)
    
    @attr = { 

    }
  end
  
  describe 'relations' do
    it{should belong_to(:documentable)}
  end
  
  describe 'upload image' do
    it {should have_attached_file(:document)}
  end
  
  describe '#not_blacklisted_file' do
    it 'should reject certain file types' do
      @document.document_content_type = 'application/exe'
      expect(@document.save).to eq false
    end
    
    it 'should accept certain file types' do
      @document.document_content_type = 'application/pdf'
      expect(@document.save).to eq true
    end
  end
end
