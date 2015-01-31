require 'spec_helper'
 
feature 'Species' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating an species' do
    scenario 'user creates an species' do
      visit admin_species_index_path
      click_on 'Add New Species'

      fill_in 'Name', with: 'Elephant'

      click_button 'Add Species'

      expect(page).to have_content 'Species was successfully created.'
    end
  end

  context 'editing/viewing an species', js: true do
    before do
      @species = FactoryGirl.create(:species,
                                   organization_id: @user.organization_id,
                                   name: 'kangaroo')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id, species_id: @species.id)
      sleep 0.2
      visit admin_species_path(@species.id)
    end

    scenario 'user edits an existing species' do
      # changing the name
      expect(page).to have_content @species.name
      change_bip_text('name', 'green')
      expect(page).to_not have_content @species.name
      expect(page).to have_content 'green'
    end

    scenario 'user can see animals of this species' do
      within '.tab-content' do
        expect(page).to have_content @animal.name
      end
    end
  end

  context 'listing species' do
    before do
      @species = FactoryGirl.create(:species,
                                    organization_id: @user.organization_id,
                                    name: 'white')
      visit admin_species_index_path
    end

    scenario 'user views a list of species' do
      within 'table' do
        expect(page).to have_content @species.name
      end
    end

    scenario 'user deletes an species', js: true do
      within first('tbody tr') do
        expect(page).to have_content @species.name

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Species was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @species.name
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:species, organization_id: @user.organization_id, name: 'yolo') }
      visit admin_species_index_path
      within first('tbody') do
        expect(page).to_not have_content @species.name
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @species.name
      end      
    end
  end
end
