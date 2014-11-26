require 'spec_helper'

describe AnimalWeight do
  before(:each) do
    @attr = { 

    }
  end
  
  describe 'relations' do
    it{should belong_to(:organization)}
    it{should belong_to(:animal)}
  
  end

  describe 'validations' do
    it{should validate_presence_of(:animal_id)}
    it{should validate_presence_of(:weight)}
    it{should validate_presence_of(:date_of_weight)}
    it{should validate_presence_of(:organization_id)}
  end

  describe '#show_weight_label_method' do
    let(:animal_weight) { FactoryGirl.create(:animal_weight) }
    
    it 'should return the weight as a string' do
      expect(animal_weight.show_weight_label_method).to eq animal_weight.weight.to_s
    end
  end
  
  describe '#formatted_weight_date' do
    let(:animal_weight) { FactoryGirl.create(:animal_weight, @attr.merge(date_of_weight: '2001-10-20 00:50:22')) }
    
    it 'should format weight date' do
      weight_date = Time.parse('2001-10-20 00:50:22').strftime('%a, %b %e at %l:%M')
      expect(animal_weight.formatted_weight_date).to eq weight_date
    end
    
    it 'should return empty string if nil' do
      animal_weight.date_of_weight = nil
      expect(animal_weight.formatted_weight_date).to eq ''
    end
  end

  describe 'comma' do
    it 'should return a csv for the object' do
      animal_weight = FactoryGirl.build(:animal_weight)
      expect(animal_weight.to_comma).to_not be_blank
    end
  end 
end
