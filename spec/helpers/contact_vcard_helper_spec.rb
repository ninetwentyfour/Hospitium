require 'spec_helper'

describe ContactVcardHelper do
  before do
    @attrs = {
      first_name: 'test_name_1'
    }

    @contact_vcard = 'BEGIN:VCARD
    VERSION:3.0
    N:last name;test_name_1;;;
    FN:test_name_1 last name
    ADR;TYPE=home,pref:;;511 Broadway Denver CO 80203;;;;
    TEL:555-555-5555
    EMAIL;TYPE=pref:example@example.com
    END:VCARD
    '.gsub("  ", "")
  end

  describe '#generate_vcard' do
    it 'should return a vcard for an adoption contact' do
      adoption_contact = FactoryGirl.build(:adoption_contact, @attrs)
      expect(helper.generate_vcard(adoption_contact).to_s).to eq @contact_vcard
    end

    it 'should return a vcard for a foster contact' do
      foster_contact = FactoryGirl.build(:foster_contact, @attrs)
      expect(helper.generate_vcard(foster_contact).to_s).to eq @contact_vcard
    end

    it 'should return a vcard for a relinquishment contact' do
      relinquishment_contact = FactoryGirl.build(:relinquishment_contact, @attrs)
      expect(helper.generate_vcard(relinquishment_contact).to_s).to eq @contact_vcard
    end

    it 'should return a vcard for a volunteer contact' do
      volunteer_contact = FactoryGirl.build(:volunteer_contact, @attrs)
      expect(helper.generate_vcard(volunteer_contact).to_s).to eq @contact_vcard
    end
  end
end
