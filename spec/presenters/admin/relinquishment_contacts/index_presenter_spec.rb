require 'spec_helper'

describe Admin::RelinquishmentContacts::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      presenter = Admin::RelinquishmentContacts::IndexPresenter.new(@user)
      expect(presenter.is_a?(Admin::RelinquishmentContacts::IndexPresenter)).to eq true
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::RelinquishmentContacts::IndexPresenter.new(@user)

      expect(presenter.animal.is_a?(ActiveRecord::Relation)).to eq true
    end
  end
end
