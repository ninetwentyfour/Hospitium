require 'spec_helper'

describe Admin::Animals::NewPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::Animals::NewPresenter.new(@user)

      expect(presenter.status.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.species.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.color.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.sex.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.spay.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.biter.is_a?(ActiveRecord::Relation)).to eq true
    end
  end
end
