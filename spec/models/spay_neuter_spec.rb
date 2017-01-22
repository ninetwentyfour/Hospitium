require 'spec_helper'

describe SpayNeuter do
  describe 'relations' do
    it { should have_many(:animals) }
  end

  describe '#show_spay_label_method' do
    let(:spay_neuter) { FactoryGirl.create(:spay_neuter) }

    it 'should return the spay value as a string' do
      expect(spay_neuter.show_spay_label_method).to eq spay_neuter.spay
    end
  end
end
