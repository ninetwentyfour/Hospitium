require 'spec_helper'
 
feature 'Status' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating a status' do
    scenario 'user creates a status' do
      visit admin_statuses_path
      click_on 'Add New Status'

      fill_in 'Status', with: 'Awesome'

      click_button 'Add Status'

      expect(page).to have_content 'Status was successfully created.'
    end
  end

  context 'editing/viewing a status', js: true do
    before do
      @status = FactoryGirl.create(:status,
                                   organization_id: @user.organization_id,
                                   status: 'awesome')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id, status_id: @status.id)
      sleep 0.2
      visit admin_status_path(@status.id)
    end

    scenario 'user edits a existing status' do
      # changing the status
      expect(page).to have_content @status.status
      change_bip_text('status', 'outbound')
      expect(page).to_not have_content @status.status
      expect(page).to have_content 'outbound'
    end

    scenario 'user can see animals of this status' do
      within '.tab-content' do
        expect(page).to have_content @animal.name
      end
    end
  end

  context 'listing status' do
    before do
      @status = FactoryGirl.create(:status,
                                    organization_id: @user.organization_id,
                                    status: 'awesome')
      visit admin_statuses_path
    end

    scenario 'user views a list of status' do
      within 'table' do
        expect(page).to have_content @status.status
      end
    end

    scenario 'user deletes a status', js: true do
      within first('tbody tr') do
        expect(page).to have_content @status.status

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Status was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @status.status
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:status, organization_id: @user.organization_id, status: 'yolo') }
      visit admin_statuses_path
      within first('tbody') do
        expect(page).to_not have_content @status.status
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @status.status
      end      
    end
  end
end
