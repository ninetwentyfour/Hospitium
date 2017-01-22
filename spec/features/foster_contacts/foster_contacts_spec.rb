require 'spec_helper'

feature 'Foster Contacts' do
  before :each do
    @user = new_logged_in_user
  end

  context 'creating an foster contact' do
    scenario 'user creates an foster contact' do
      visit admin_foster_contacts_path
      click_on 'Add New Foster Contact'

      fill_in 'First name', with: 'Billy'
      fill_in 'Last name', with: 'Bob'
      fill_in 'Address', with: 'Fake street'
      fill_in 'Phone', with: '555-5555'
      fill_in 'Email', with: 'billy@example.com'

      click_button 'Add Foster Contact'

      expect(page).to have_content 'Foster Contact was successfully created.'
    end
  end

  context 'editing/viewing an foster contact', js: true do
    before do
      contact = FactoryGirl.create(:foster_contact,
                                   organization_id: @user.organization_id,
                                   email: 'test@example.com',
                                   phone: '5555554',
                                   address: '123 fake st',
                                   first_name: 'billy',
                                   last_name: 'bob')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id)
      sleep 0.2
      visit admin_foster_contact_path(contact.id)
    end

    scenario 'user edits an existing foster contact' do
      # changing the name
      expect(page).to have_content 'billy'
      expect(page).to have_content 'bob'
      change_bip_text('first_name', 'joe')
      change_bip_text('last_name', 'jack')
      expect(page).to_not have_content 'billy'
      expect(page).to have_content 'joe'
      expect(page).to_not have_content 'bob'
      expect(page).to have_content 'jack'

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

    scenario 'user can add and remove animals to an foster contact' do
      # add
      within '.nav-tabs' do
        click_on 'Animals'
      end
      click_on 'Add Animal'
      click_on 'Submit'
      expect(page).to have_content 'Foster Animal was successfully created.'
      within '.nav-tabs' do
        click_on 'Animals'
      end
      within '.tab-content' do
        expect(page).to have_content @animal.name
      end

      # remove
      page.find('.fa-remove').click
      expect(page).to have_content 'Animal successfully removed.'
      within '.nav-tabs' do
        click_on 'Animals'
      end
      within '.tab-content' do
        expect(page).to_not have_content @animal.name
      end
    end

    scenario 'user can download a vcard of the contact', js: false do
      click_on 'Download Contact'
      expect(page.text).to eq 'BEGIN:VCARD VERSION:3.0 N:bob;billy;;; FN:billy bob ADR;TYPE=home,pref:;;123 fake st;;;; TEL:555-5554 EMAIL;TYPE=pref:test@example.com END:VCARD'
      expect(page.response_headers['Content-Type']).to eq 'text/vcard; charset=utf-8'
    end
  end

  context 'listing foster contacts' do
    before do
      @contact = FactoryGirl.create(:foster_contact,
                                    organization_id: @user.organization_id)
      visit admin_foster_contacts_path
    end

    scenario 'user views a list of foster contacts' do
      within 'table' do
        expect(page).to have_content @contact.first_name
        expect(page).to have_content @contact.last_name
      end
    end

    scenario 'user can sort the table', js: true do
      second_contact = FactoryGirl.create(:foster_contact,
                                          organization_id: @user.organization_id,
                                          first_name: 'zelda',
                                          email: 'a@example.com')
      visit admin_foster_contacts_path
      within first('tbody tr') do
        expect(page).to have_content second_contact.first_name
        expect(page).to have_content second_contact.last_name
      end

      within 'thead' do
        click_on 'First name'
      end

      within first('tbody tr') do
        expect(page).to have_content @contact.first_name
        expect(page).to have_content @contact.last_name
      end

      within 'thead' do
        click_on 'Email'
      end

      within first('tbody tr') do
        expect(page).to have_content second_contact.first_name
        expect(page).to have_content second_contact.last_name
      end
    end

    scenario 'user downloads a csv of the foster contacts' do
      require 'csv'
      click_on 'Export'
      expect(page.response_headers['Content-Type']).to eq 'text/csv'
      csv = CSV.parse(page.body)

      expect(csv.first).to eq ['ID', 'First Name', 'Last Name', 'Address', 'Phone', 'Email', 'Fostered Animal IDs']
      expect(csv.last).to eq [@contact.id,
                              @contact.first_name,
                              @contact.last_name,
                              @contact.address,
                              @contact.phone,
                              @contact.email,
                              @contact.animals.map(&:id).join(',')]
    end

    scenario 'user deletes an foster contact', js: true do
      within first('tbody tr') do
        expect(page).to have_content @contact.first_name
        expect(page).to have_content @contact.last_name

        page.find('.fa-remove').click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Foster Contact was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @contact.first_name
        expect(page).to_not have_content @contact.last_name
      end
    end

    scenario 'searches for a contact', js: true do
      second_contact = FactoryGirl.create(:foster_contact,
                                          organization_id: @user.organization_id,
                                          first_name: 'zelda',
                                          last_name: 'link')
      visit admin_foster_contacts_path
      within first('tbody') do
        expect(page).to have_content second_contact.first_name
        expect(page).to have_content second_contact.last_name
        expect(page).to have_content @contact.first_name
        expect(page).to have_content @contact.last_name
      end

      click_on 'Advanced Search'

      fill_in 'First name contains', with: 'zel'

      click_on 'Submit'

      within first('tbody') do
        expect(page).to have_content second_contact.first_name
        expect(page).to have_content second_contact.last_name
        expect(page).to_not have_content @contact.first_name
        expect(page).to_not have_content @contact.last_name
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:foster_contact, organization_id: @user.organization_id, first_name: 'yolo') }
      visit admin_foster_contacts_path
      within first('tbody') do
        expect(page).to_not have_content @contact.first_name
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @contact.first_name
      end
    end
  end
end
