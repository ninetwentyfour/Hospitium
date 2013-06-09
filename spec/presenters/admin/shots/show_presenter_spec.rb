require 'spec_helper'

describe Admin::Shots::ShowPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
    @shot = FactoryGirl.create(:shot)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      @presenter = Admin::Shots::ShowPresenter.new(@shot.id, @user)
      @presenter.should_not be_nil
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      @presenter = Admin::Shots::ShowPresenter.new(@shot.id, @user)

      @presenter.animals.should_not be_nil
      @presenter.shot.should_not be_nil
    end
  end

end