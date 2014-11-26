require 'spec_helper'

describe Species do
  before(:each) do
    @attr = { 

    }
  end
  
  describe 'relations' do
    it{should belong_to(:organization)}
    it{should have_many(:animals)}
  end

  describe 'validations' do
    it{should validate_presence_of(:name)}
    it{should validate_presence_of(:organization_id)}
  end
end
