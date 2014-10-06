require 'spec_helper'

describe Admin::AdoptionContacts::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      @presenter = Admin::AdoptionContacts::IndexPresenter.new(@user, nil, nil, nil)
      @presenter.should_not be_nil
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      @presenter = Admin::AdoptionContacts::IndexPresenter.new(@user, nil, nil, nil)

      @presenter.animal.should_not be_nil
      @presenter.adoption_contacts.should_not be_nil
      @presenter.search.should_not be_nil
    end
  end

end