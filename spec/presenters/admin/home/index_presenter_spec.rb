require 'spec_helper'

describe Admin::Home::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      @presenter = Admin::Home::IndexPresenter.new(@user)
      @presenter.should_not be_nil
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      @presenter = Admin::Home::IndexPresenter.new(@user)

      @presenter.status_chart.should_not be_nil
      @presenter.species_chart.should_not be_nil
      @presenter.colors_chart.should_not be_nil
      @presenter.latest_activity.should_not be_nil
      @presenter.public_animals.should_not be_nil
      @presenter.total_animals.should_not be_nil
      @presenter.total_species.should_not be_nil
      @presenter.total_contacts.should_not be_nil
      @presenter.total_events.should_not be_nil
      @presenter.sex_chart.should_not be_nil
      @presenter.animals_sparkline.should_not be_nil
      @presenter.species_sparkline.should_not be_nil
      @presenter.contacts_sparkline.should_not be_nil
      @presenter.events_sparkline.should_not be_nil
    end
  end

end