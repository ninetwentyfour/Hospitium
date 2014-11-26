require 'spec_helper'

describe Admin::Shots::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      presenter = Admin::Shots::IndexPresenter.new(@user, nil, nil, nil)
      expect(presenter.is_a?(Admin::Shots::IndexPresenter)).to eq true
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::Shots::IndexPresenter.new(@user, nil, nil, nil)

      expect(presenter.animals.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.shots.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.search.is_a?(Ransack::Search)).to eq true
    end
  end
end
