require 'spec_helper'

describe Organization do
  let(:organization) { FactoryGirl.create(:organization) }

  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should have_many(:adoption_contacts) }
    it { should have_many(:animals) }
    it { should have_many(:animal_colors) }
    it { should have_many(:animal_weights) }
    it { should have_many(:facebook_accounts) }
    it { should have_many(:relinquishment_contacts) }
    it { should have_many(:shelters) }
    it { should have_many(:species) }
    it { should have_many(:statuses) }
    it { should have_many(:twitter_accounts) }
    it { should have_many(:vet_contacts) }
    it { should have_many(:volunteer_contacts) }
    it { should have_many(:wordpress_accounts) }
    it { should have_many(:users) }
  end

  describe '#add_default_status' do
    it 'should create default statuses' do
      expect(organization.statuses.size).to eq 7
    end
  end

  describe '#add_default_animal_colors' do
    it 'should create default animal colors' do
      expect(organization.animal_colors.size).to eq 4
    end
  end

  describe '#add_default_species' do
    it 'should create default species' do
      expect(organization.species.size).to eq 8
    end
  end

  describe '#modify_phone_number' do
    it 'should strip characters from the phone number' do
      organization.update_attributes(phone_number: '123-456-7890')
      expect(organization.phone_number).to eq '1234567890'
    end
  end

  describe '#formatted_phone' do
    it 'should format phone number' do
      organization.update_attributes(phone_number: '123-456-7890')
      expect(organization.formatted_phone).to eq '123-456-7890'
    end

    it 'should return empty string if nil' do
      organization.phone_number = nil
      expect(organization.formatted_phone).to eq ''
    end
  end

  describe 'has_info?' do
    it 'should return true for orgs with an email' do
      org = FactoryGirl.create(:organization, email: 'test@example.com')
      expect(org.has_info?).to eq true
    end

    it 'should return true for orgs with an phone' do
      org = FactoryGirl.create(:organization, phone_number: '5555555555')
      expect(org.has_info?).to eq true
    end

    it 'should return true for orgs with an website' do
      org = FactoryGirl.create(:organization, website: 'example.com')
      expect(org.has_info?).to eq true
    end

    it 'should return false for orgs with no info' do
      expect(organization.has_info?).to eq false
    end
  end

  describe 'forms' do
    it 'should set a default url for adoption forms' do
      expect(organization.adoption_form.url).to eq 'https://d4uktpxr9m70.cloudfront.net/pdfs/Adoption-Form.pdf'
    end

    it 'should set a default url for volunteer forms' do
      expect(organization.volunteer_form.url).to eq 'https://d4uktpxr9m70.cloudfront.net/pdfs/Volunteer-Application.pdf'
    end
  end
end
