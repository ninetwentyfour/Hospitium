require 'spec_helper'
 
feature 'Vet Contacts' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating a vet_contact' do
    scenario 'user creates a vet_contact' do
      visit admin_vet_contacts_path
      click_on 'Add New Vet Contact'

      fill_in 'Clinic name', with: 'Example Vet Contact'
      fill_in 'Address', with: 'Fake street'
      fill_in 'Phone', with: '555-5555'
      fill_in 'Email', with: 'exampleshelter@example.com'

      click_button 'Add Vet Contact'

      expect(page).to have_content 'Vet Contact was successfully created.'
    end
  end

  context 'editing/viewing a vet_contact', js: true do
    before do
      contact = FactoryGirl.create(:vet_contact,
                                   organization_id: @user.organization_id,
                                   email: 'test@example.com',
                                   phone: '5555554',
                                   address: '123 fake st',
                                   clinic_name: 'example vet_contact')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id, shelter_id: contact.id)
      sleep 0.2
      visit admin_vet_contact_path(contact.id)
    end

    scenario 'user edits a existing vet_contact' do
      # changing the clinic_name
      expect(page).to have_content 'example vet_contact'
      change_bip_text('clinic_name', 'new clinic_name')
      expect(page).to_not have_content 'example vet_contact'
      expect(page).to have_content 'new clinic_name'

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
  end

  context 'listing vet_contacts' do
    before do
      @contact = FactoryGirl.create(:vet_contact,
                                    organization_id: @user.organization_id)
      visit admin_vet_contacts_path
    end

    scenario 'user views a list of vet_contacts' do
      within 'table' do
        expect(page).to have_content @contact.clinic_name
      end
    end

    scenario 'user can sort the table', js: true do
      second_contact = FactoryGirl.create(:vet_contact,
                                          organization_id: @user.organization_id,
                                          clinic_name: 'zelda',
                                          email: 'a@example.com')
      visit admin_vet_contacts_path
      within first('tbody tr') do
        expect(page).to have_content second_contact.clinic_name
      end

      within 'thead' do
        click_on 'Clinic name'
      end

      within first('tbody tr') do
        expect(page).to have_content @contact.clinic_name
      end
    end

    scenario 'user downloads a csv of the vet_contacts' do
      require 'csv'
      click_on 'Export'
      expect(page.response_headers['Content-Type']).to eq 'text/csv'
      csv = CSV.parse(page.body)

      expect(csv.first).to eq ['ID', 'Clinic Name', 'Address', 'Phone', 'Email', 'Website', 'Hours', 'Emergency']
      expect(csv.last).to eq [@contact.id, 
                              @contact.clinic_name,
                              @contact.address,
                              @contact.phone,
                              @contact.email,
                              @contact.website,
                              @contact.hours,
                              @contact.emergency]
    end

    scenario 'user deletes a vet_contact', js: true do
      within first('tbody tr') do
        expect(page).to have_content @contact.clinic_name

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Vet Contact was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @contact.clinic_name
      end
    end

    scenario 'searches for a contact', js: true do
      second_contact = FactoryGirl.create(:vet_contact,
                                          organization_id: @user.organization_id,
                                          clinic_name: 'zelda')
      visit admin_vet_contacts_path
      within first('tbody') do
        expect(page).to have_content second_contact.clinic_name
        expect(page).to have_content @contact.clinic_name
      end

      click_on 'Advanced Search'

      fill_in 'Clinic name contains', with: 'zel'

      click_on 'Submit'

      within first('tbody') do
        expect(page).to have_content second_contact.clinic_name
        expect(page).to_not have_content @contact.clinic_name
      end      
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:vet_contact, organization_id: @user.organization_id, clinic_name: 'yolo') }
      visit admin_vet_contacts_path
      within first('tbody') do
        expect(page).to_not have_content @contact.clinic_name
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @contact.clinic_name
      end      
    end
  end
end
