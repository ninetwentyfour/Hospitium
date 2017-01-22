require 'spec_helper'

feature 'Shots' do
  before :each do
    @user = new_logged_in_user
  end

  context 'creating a shot' do
    scenario 'user creates a shot', js: true do
      FactoryGirl.create(:animal, organization_id: @user.organization_id)
      visit admin_shots_path
      click_on 'Add New Shot'

      fill_in 'Name', with: 'Health Juice'

      page.find('#shot_last_administered').set '03 Jan 2015'
      page.find('#shot_expires').set '03 Jan 2015'

      page.find("input[name='commit']").trigger('click')

      expect(page).to have_content 'Shot was successfully created.'
    end
  end

  context 'editing/viewing a shot', js: true do
    before do
      @shot = FactoryGirl.create(:shot,
                                 organization_id: @user.organization_id,
                                 name: 'super fun')
      sleep 0.2
      visit admin_shot_path(@shot.id)
    end

    scenario 'user edits a existing shot' do
      # changing the shot
      expect(page).to have_content @shot.name
      change_bip_text('name', 'new name')
      expect(page).to_not have_content @shot.name
      expect(page).to have_content 'new name'
    end
  end

  context 'listing shots' do
    before do
      @shot = FactoryGirl.create(:shot,
                                 organization_id: @user.organization_id,
                                 name: 'awesome')
      visit admin_shots_path
    end

    scenario 'user views a list of shots' do
      within 'table' do
        expect(page).to have_content @shot.name
      end
    end

    scenario 'user downloads a csv of the shots' do
      require 'csv'
      click_on 'Export'
      expect(page.response_headers['Content-Type']).to eq 'text/csv'
      csv = CSV.parse(page.body)

      expect(csv.first).to eq ['ID', 'Name', 'Animal', 'Last Administered', 'Expires']
      expect(csv.last).to include @shot.id
    end

    scenario 'user deletes a shot', js: true do
      within first('tbody tr') do
        expect(page).to have_content @shot.name

        page.find('.fa-remove').click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Shot was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @shot.name
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:shot, organization_id: @user.organization_id, name: 'medicine') }
      visit admin_shots_path
      within first('tbody') do
        expect(page).to_not have_content @shot.name
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @shot.name
      end
    end
  end
end
