require 'spec_helper'

describe Admin::Animals::ShowPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
    @animal = FactoryGirl.create(:animal, :organization_id => @user.organization_id)
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      @presenter = Admin::Animals::ShowPresenter.new(@user, @animal)

      @presenter.statuses.should_not be_nil
      @presenter.species.should_not be_nil
      @presenter.colors.should_not be_nil
      @presenter.shelters.should_not be_nil
      @presenter.animal_weights.should_not be_nil
      @presenter.notes.should_not be_nil
      @presenter.documents.should_not be_nil
    end
  end

end