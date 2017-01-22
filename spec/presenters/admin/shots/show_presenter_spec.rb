require 'spec_helper'

describe Admin::Shots::ShowPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
    @shot = FactoryGirl.create(:shot)
  end

  describe '#initialize' do
    it 'create presenter' do
      presenter = Admin::Shots::ShowPresenter.new(@shot.id, @user)
      expect(presenter.is_a?(Admin::Shots::ShowPresenter)).to eq true
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::Shots::ShowPresenter.new(@shot.id, @user)

      expect(presenter.animals.is_a?(Array)).to eq true
      expect(presenter.shot.is_a?(Shot)).to eq true
    end
  end
end
