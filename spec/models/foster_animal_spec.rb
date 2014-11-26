require 'spec_helper'

describe FosterAnimal do

  context 'when delegating methods to animal object' do
    it { should respond_to(:name) }
  end

  context 'when delegating methods to foster_contact object' do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
  end

  describe 'relations' do
    it{should belong_to(:animal)}
    it{should belong_to(:foster_contact)}
  end
end
