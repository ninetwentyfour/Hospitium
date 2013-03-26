require 'spec_helper'

describe Admin::Animals::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      @presenter = Admin::Animals::IndexPresenter.new(@user)

      @presenter.status.should_not be_nil
      @presenter.species.should_not be_nil
      @presenter.color.should_not be_nil
      @presenter.shelter.should_not be_nil
      @presenter.sex.should_not be_nil
      @presenter.spay.should_not be_nil
      @presenter.biter.should_not be_nil
    end
  end

end