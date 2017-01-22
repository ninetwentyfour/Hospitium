require 'spec_helper'

describe 'Existing User Dashboard' do
  before :each do
    @user = existing_logged_in_user

    visit admin_root_path
  end

  it 'does not show the Initial Setup instructions to the user' do
    expect(page).to_not have_content('Initial Setup')
    expect(page).to_not have_content('Before doing anything else with your new account')
  end

  describe 'single account stats' do
    it 'should show the count of animals the user has' do
      within first('.fd-tile') do
        expect(page).to have_content 'Total number of animals'
        expect(page).to have_content '1'
      end
    end

    it 'should show the count of species the user has' do
      within all('.fd-tile')[1] do
        expect(page).to have_content 'Total number of species'
        expect(page).to have_content '9'
      end
    end

    it 'should show the count of contacts the user has' do
      within all('.fd-tile')[2] do
        expect(page).to have_content 'Total number of contacts'
        expect(page).to have_content '1'
      end
    end

    it 'should show the count of events the user has' do
      within all('.fd-tile')[3] do
        expect(page).to have_content 'Total number of events'
        expect(page).to have_content '0'
      end
    end
  end

  describe 'charts' do
    it 'should have all the charts' do
      expect(page).to have_content 'Animal Statuses'
      expect(page).to have_content 'Animal Species'
      expect(page).to have_content 'Animal Colors'
      expect(page).to have_content 'Animal Sexes'
    end
  end

  describe 'public activity' do
    it 'shows the recent organization activity' do
      PublicActivity.with_tracking do
        # do something to generate some activity
        visit new_admin_foster_contact_path
        fill_in 'First name', with: 'Tom'
        fill_in 'Last name', with: 'Jones'
        fill_in 'Address', with: 'test'
        fill_in 'Phone', with: '5555555555'
        fill_in 'Email', with: 'test@example.com'
        click_button 'Add Foster Contact'
        # now you can see it on the dashboard
        visit admin_root_path
        within '.timeline' do
          expect(page).to have_content "#{@user.username} has created a foster contact:"
          expect(page).to have_content 'Tom Jones was created.'
        end
      end
    end
  end

  describe 'public animals' do
    before do
      @animal = FactoryGirl.create(:animal, public: true, organization_id: @user.organization_id)
      visit admin_root_path
    end

    it 'should show all public animals' do
      within '#public_animals_list' do
        expect(page).to have_content @animal.name
        expect(page).to have_content '0'
      end
    end

    # it 'should show how many times the public animal has been viewed on the public page' do
    #   # go visit the public page to generate a view
    #   visit animal_path(@animal)
    #   within first('.block-flat') do
    #     expect(page).to have_content @animal.name
    #   end
    #   # now go see the stat
    #   visit admin_root_path
    #   within '#public_animals_list' do
    #     expect(page).to have_content @animal.name
    #     expect(page).to have_content '1'
    #   end
    # end
  end
end
