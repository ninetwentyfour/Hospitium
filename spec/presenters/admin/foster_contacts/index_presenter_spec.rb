require 'spec_helper'

describe Admin::FosterContacts::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      presenter = Admin::FosterContacts::IndexPresenter.new(@user, nil, nil)
      expect(presenter.is_a?(Admin::FosterContacts::IndexPresenter)).to eq true
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::FosterContacts::IndexPresenter.new(@user, nil, nil)

      expect(presenter.animal.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.foster_contacts.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.search.is_a?(Ransack::Search)).to eq true
    end
  end
end
