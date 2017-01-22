require 'spec_helper'

describe User do
  before(:each) do
    @attr = {

    }
  end

  describe 'relations' do
    it { should belong_to(:organization) }
    it { should have_many(:permissions) }
    it { should have_many(:twitter_accounts) }
    it { should have_many(:facebook_accounts) }
    it { should have_many(:wordpress_accounts) }
    it { should have_many(:adopt_a_pet_accounts) }
    it { should have_many(:notes) }
    it { should have_many(:roles) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:organization_name) }
  end

  # describe 'abilities' do
  #   before(:each) do
  #     @user = FactoryGirl.create(:user)
  #     @user.roles << FactoryGirl.create(:role)
  #   end
  #   it 'should be able to manage animal' do
  #     ability = Ability.new(@user)
  #     animal = FactoryGirl.create(:animal, organization_id: @user.organization_id)

  #     expect(ability).to be_able_to(:read, animal)
  #     expect(ability).to be_able_to(:create, animal)
  #     expect(ability).to be_able_to(:update, animal)
  #     expect(ability).to be_able_to(:duplicate, animal)
  #     expect(ability).to be_able_to(:qr_code, animal)
  #     expect(ability).to be_able_to(:cage_card, animal)
  #     expect(ability).to be_able_to(:export, animal)
  #     expect(ability).to be_able_to(:bulk_action, animal)
  #     expect(ability).to be_able_to(:destroy, animal)
  #   end
  # end

  describe '#add_default_role owner' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should create default role for the org owner' do
      expect(user.permissions.first.role_id).to eq 2
    end
  end

  describe '#add_default_role user' do
    let(:user) { FactoryGirl.create(:user, @attr.merge(owner: 0)) }

    it 'should create default role for the org user' do
      expect(user.permissions.first.role_id).to eq 3
    end
  end

  describe '#add_to_organization' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should add user to an organization' do
      expect(user.organization_id).to_not be_nil
    end
  end

  describe 'permissions and roles' do
    it 'should have 1 role' do
      user = FactoryGirl.create(:user)
      user.roles << FactoryGirl.create(:role)
      expect(user.roles.length).to eq 1
    end

    it 'should have 1 permission' do
      user = FactoryGirl.create(:user)
      permission = FactoryGirl.create(:permission)
      expect(user.permissions.length).to eq 1
    end
  end

  describe '#show_username_label_method' do
    let(:user) { FactoryGirl.create(:user) }

    it 'should return the username value as a string' do
      expect(user.show_username_label_method).to eq user.username
    end
  end

  describe '#role?' do
    it 'should return true for Admin role' do
      user = FactoryGirl.create(:user)
      user.roles << FactoryGirl.create(:role)
      expect(user.role?('Admin')).to eq true
    end
  end

  describe '#add_to_organization' do
    it 'should set organization if org_id nil' do
      user = FactoryGirl.create(:user)
      user.organization_id = nil
      user.add_to_organization
      expect(user.organization_id).to_not be_nil
      expect(user.organization.name).to_not be_blank
    end
  end
end
