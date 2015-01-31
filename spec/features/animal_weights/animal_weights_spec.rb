require 'spec_helper'
 
feature 'Animal Weights' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating an animal weight' do
    scenario 'user creates an animal weight', js: true do
      FactoryGirl.create(:animal, organization_id: @user.organization_id)
      visit admin_animal_weights_path
      click_on 'Add New Animal Weight'

      fill_in 'Weight', with: 'Pink'
      page.find('#animal_weight_date_of_weight').set '03 Jan 2015'

      page.find("input[name='commit']").trigger('click')

      expect(page).to have_content 'Animal Weight was successfully created.'
    end
  end

  context 'editing/viewing an animal weight', js: true do
    before do
      @weight = FactoryGirl.create(:animal_weight,
                                   organization_id: @user.organization_id,
                                   weight: 1111115)
      sleep 0.2
      visit admin_animal_weight_path(@weight.id)
    end

    scenario 'user edits an existing animal weight' do
      # changing the weight
      expect(page).to have_content @weight.weight
      change_bip_text('weight', 22250)
      expect(page).to_not have_content @weight.weight
      expect(page).to have_content '22250'
    end
  end

  context 'listing animal weights' do
    before do
      @weight = FactoryGirl.create(:animal_weight,
                                    organization_id: @user.organization_id,
                                    weight: 66667)
      visit admin_animal_weights_path
    end

    scenario 'user views a list of animal weights' do
      within 'table' do
        expect(page).to have_content @weight.weight
      end
    end

    scenario 'user downloads a csv of the animal weights' do
      require 'csv'
      click_on 'Export'
      expect(page.response_headers['Content-Type']).to eq 'text/csv'
      csv = CSV.parse(page.body)

      expect(csv.first).to eq ['ID', 'Weight', 'Animal', 'Date of Weight']
      expect(csv.last).to include @weight.id
    end

    scenario 'user deletes an animal weight', js: true do
      within first('tbody tr') do
        expect(page).to have_content @weight.weight

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Animal Weight was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @weight.weight
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:animal_weight, organization_id: @user.organization_id, weight: 999) }
      visit admin_animal_weights_path
      within first('tbody') do
        expect(page).to_not have_content @weight.weight
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @weight.weight
      end      
    end
  end
end
