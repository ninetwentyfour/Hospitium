require 'spec_helper'

describe Admin::Animals::ShowPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
    @animal = FactoryGirl.create(:animal, :organization_id => @user.organization_id)
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::Animals::ShowPresenter.new(@user, @animal)

      expect(presenter.statuses.is_a?(Array)).to eq true
      expect(presenter.species.is_a?(Array)).to eq true
      expect(presenter.colors.is_a?(Array)).to eq true
      expect(presenter.shelters.is_a?(Array)).to eq true
      expect(presenter.animal_weights.is_a?(Hash)).to eq true
      expect(presenter.notes.is_a?(ActiveRecord::Relation)).to eq true
      expect(presenter.documents.is_a?(ActiveRecord::Relation)).to eq true
    end
  end
end
