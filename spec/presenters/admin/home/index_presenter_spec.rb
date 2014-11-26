require 'spec_helper'

describe Admin::Home::IndexPresenter do
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe '#initialize' do
    it 'create presenter' do
      presenter = Admin::Home::IndexPresenter.new(@user)
      expect(presenter.is_a?(Admin::Home::IndexPresenter)).to eq true
    end
  end

  describe 'presenter methods' do
    it 'should have all the presenter methods' do
      presenter = Admin::Home::IndexPresenter.new(@user)

      expect(presenter.status_chart).to_not eq nil
      expect(presenter.species_chart).to_not eq nil
      expect(presenter.colors_chart).to_not eq nil
      expect(presenter.latest_activity).to_not eq nil
      expect(presenter.public_animals).to_not eq nil
      expect(presenter.total_animals).to_not eq nil
      expect(presenter.total_species).to_not eq nil
      expect(presenter.total_contacts).to_not eq nil
      expect(presenter.total_events).to_not eq nil
      expect(presenter.sex_chart).to_not eq nil
      expect(presenter.animals_sparkline).to_not eq nil
      expect(presenter.species_sparkline).to_not eq nil
      expect(presenter.contacts_sparkline).to_not eq nil
      expect(presenter.events_sparkline).to_not eq nil
    end
  end
end
