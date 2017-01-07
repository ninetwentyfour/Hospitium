require 'spec_helper'

feature 'Species' do
  before :each do
    @user = new_logged_in_user
    @organization = @user.organization
    @organization.website = 'http://www.example.com'
    @organization.email = 'test@example.com'
    @organization.phone_number = '5555554'
    @organization.address = '123 fake st'
    @organization.city = 'manhattan'
    @organization.state = 'colorado'
    @organization.zip_code = '66502'
    @organization.save
  end

  context 'editing/viewing an organization', js: true do
    before do
      visit admin_organizations_path
    end

    scenario 'user edits an existing organization' do
      # changing the name
      within first('.block-flat') do
        expect(page).to have_content @organization.name
        change_bip_text('name', 'new org')
        expect(page).to_not have_content @organization.name
        expect(page).to have_content 'new org'
      end

      # changing the website
      expect(page).to have_content @organization.website
      change_bip_text('website', 'http://example.com/superfresh')
      expect(page).to_not have_content @organization.website
      expect(page).to have_content 'http://example.com/superfresh'

      # chaging the email
      expect(page).to have_content @organization.email
      change_bip_text('email', 'new@example.com')
      expect(page).to_not have_content @organization.email
      expect(page).to have_content 'new@example.com'

      # changing the phone
      expect(page).to have_content '555-5554'
      change_bip_text('phone_number', '5555555')
      expect(page).to_not have_content @organization.phone_number
      expect(page).to have_content '5555555'

      # changing the address
      expect(page).to have_content @organization.address
      change_bip_text('address', '124 fake street')
      expect(page).to_not have_content @organization.address
      expect(page).to have_content '124 fake street'

      # changing the city
      expect(page).to have_content @organization.city
      change_bip_text('city', 'denver')
      expect(page).to_not have_content @organization.city
      expect(page).to have_content 'denver'

      # changing the state
      expect(page).to have_content @organization.state
      change_bip_text('state', 'kansas')
      expect(page).to_not have_content @organization.state
      expect(page).to have_content 'kansas'

      # changing the zip
      expect(page).to have_content @organization.zip_code
      change_bip_text('zip_code', '80204')
      expect(page).to_not have_content @organization.zip_code
      expect(page).to have_content '80204'
    end

    xscenario 'user uploads forms' do
      # add adoption form
      VCR.use_cassette('features/org_adopt_add', :match_requests_on => [:method]) do
        # add
        click_on 'Add Adoption Form'
        attach_file('organization_adoption_form', File.absolute_path('./spec/fixtures/Animal_Surrender_Form.pdf'))
        click_on 'Save changes'
        expect(page).to have_content 'Update successful'
      end

      # add volunteer form
      VCR.use_cassette('features/org_volunteer_add', :match_requests_on => [:method]) do
        # add
        click_on 'Add Volunteer Form'
        attach_file('organization_volunteer_form', File.absolute_path('./spec/fixtures/Animal_Surrender_Form.pdf'))
        click_on 'Save changes'
        expect(page).to have_content 'Update successful'
      end

      # add relinquishment form
      VCR.use_cassette('features/org_relinquishment_add', :match_requests_on => [:method]) do
        # add
        click_on 'Add Relinquishment Form'
        attach_file('organization_relinquishment_form', File.absolute_path('./spec/fixtures/Animal_Surrender_Form.pdf'))
        click_on 'Save changes'
        expect(page).to have_content 'Update successful'
      end

      # add foster form
      VCR.use_cassette('features/org_foster_add', :match_requests_on => [:method]) do
        # add
        click_on 'Add Foster Form'
        attach_file('organization_foster_form', File.absolute_path('./spec/fixtures/Animal_Surrender_Form.pdf'))
        click_on 'Save changes'
        expect(page).to have_content 'Update successful'
      end
    end

    scenario 'user cancels account' do
    end
  end
end
