require 'spec_helper'
 
feature 'Shelters' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating a shelter' do
    scenario 'user creates a shelter' do
      visit admin_shelters_path
      click_on 'Add New Shelter'

      fill_in 'Name', with: 'Example Shelter'
      fill_in 'Address', with: 'Fake street'
      fill_in 'Phone', with: '555-5555'
      fill_in 'Email', with: 'exampleshelter@example.com'

      click_button 'Add Shelter'

      expect(page).to have_content 'Shelter was successfully created.'
    end
  end

  context 'editing/viewing a shelter', js: true do
    before do
      contact = FactoryGirl.create(:shelter,
                                   organization_id: @user.organization_id,
                                   email: 'test@example.com',
                                   phone: '5555554',
                                   address: '123 fake st',
                                   name: 'example shelter')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id, shelter_id: contact.id)
      sleep 0.2
      visit admin_shelter_path(contact.id)
    end

    scenario 'user edits a existing shelter' do
      # changing the name
      expect(page).to have_content 'example shelter'
      change_bip_text('name', 'new name')
      expect(page).to_not have_content 'example shelter'
      expect(page).to have_content 'new name'

      # changing the phone number
      expect(page).to have_content '555-5554'
      change_bip_text('phone', '555-5555')
      expect(page).to_not have_content '555-5554'
      expect(page).to have_content '555-5555'

      # changing the email address
      expect(page).to have_content 'test@example.com'
      change_bip_text('email', 'newemail@example.com')
      expect(page).to_not have_content 'test@example.com'
      expect(page).to have_content 'newemail@example.com'

      # changing the address
      expect(page).to have_content '123 fake st'
      change_bip_text('address', '789 not real ave')
      expect(page).to_not have_content '123 fake st'
      expect(page).to have_content '789 not real ave'
    end

    scenario 'user can view animals from the shelter' do
      within '.nav-tabs' do
        click_on 'Animals'
      end
      within '.tab-content' do
        expect(page).to have_content @animal.name
      end
    end
  end

  context 'listing shelters' do
    before do
      @contact = FactoryGirl.create(:shelter,
                                    organization_id: @user.organization_id)
      visit admin_shelters_path
    end

    scenario 'user views a list of shelters' do
      within 'table' do
        expect(page).to have_content @contact.name
      end
    end

    scenario 'user can sort the table', js: true do
      second_contact = FactoryGirl.create(:shelter,
                                          organization_id: @user.organization_id,
                                          name: 'zelda',
                                          email: 'a@example.com')
      visit admin_shelters_path
      within first('tbody tr') do
        expect(page).to have_content second_contact.name
      end

      within 'thead' do
        click_on 'Name'
      end

      within first('tbody tr') do
        expect(page).to have_content @contact.name
      end

      within 'thead' do
        click_on 'Email'
      end

      within first('tbody tr') do
        expect(page).to have_content second_contact.name
      end
    end

    scenario 'user downloads a csv of the shelters' do
      require 'csv'
      click_on 'Export'
      expect(page.response_headers['Content-Type']).to eq 'text/csv'
      csv = CSV.parse(page.body)

      expect(csv.first).to eq ['ID', 'Name', 'Contact First Name', 'Contact Last Name', 'Address', 'Phone', 'Email', 'Website', 'Notes']
      expect(csv.last).to eq [@contact.id, 
                              @contact.name,
                              @contact.contact_first,
                              @contact.contact_last,
                              @contact.address,
                              @contact.phone,
                              @contact.email,
                              @contact.website,
                              @contact.notes]
    end

    scenario 'user deletes a shelter', js: true do
      within first('tbody tr') do
        expect(page).to have_content @contact.name

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Shelter was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @contact.name
      end
    end

    scenario 'searches for a contact', js: true do
      second_contact = FactoryGirl.create(:shelter,
                                          organization_id: @user.organization_id,
                                          name: 'zelda')
      visit admin_shelters_path
      within first('tbody') do
        expect(page).to have_content second_contact.name
        expect(page).to have_content @contact.name
      end

      click_on 'Advanced Search'

      fill_in 'Name contains', with: 'zel'

      click_on 'Submit'

      within first('tbody') do
        expect(page).to have_content second_contact.name
        expect(page).to_not have_content @contact.name
      end      
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:shelter, organization_id: @user.organization_id, name: 'yolo') }
      visit admin_shelters_path
      within first('tbody') do
        expect(page).to_not have_content @contact.name
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @contact.name
      end      
    end
  end
end
