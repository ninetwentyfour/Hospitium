require 'spec_helper'
 
feature 'Animal Colors' do 
  before :each do
    @user = new_logged_in_user
  end
 
  context 'creating an animal color' do
    scenario 'user creates an animal color' do
      visit admin_animal_colors_path
      click_on 'Add New Animal Color'

      fill_in 'Color', with: 'Pink'

      click_button 'Add Animal Color'

      expect(page).to have_content 'Animal Color was successfully created.'
    end
  end

  context 'editing/viewing an animal color', js: true do
    before do
      @color = FactoryGirl.create(:animal_color,
                                   organization_id: @user.organization_id,
                                   color: 'super orange')
      @animal = FactoryGirl.create(:animal, organization_id: @user.organization_id, animal_color_id: @color.id)
      sleep 0.2
      visit admin_animal_color_path(@color.id)
    end

    scenario 'user edits an existing animal color' do
      # changing the color
      expect(page).to have_content @color.color
      change_bip_text('color', 'green')
      expect(page).to_not have_content @color.color
      expect(page).to have_content 'green'
    end

    scenario 'user can see animals of this color' do
      within '.tab-content' do
        expect(page).to have_content @animal.name
      end
    end
  end

  context 'listing animal colors' do
    before do
      @color = FactoryGirl.create(:animal_color,
                                    organization_id: @user.organization_id,
                                    color: 'white')
      visit admin_animal_colors_path
    end

    scenario 'user views a list of animal colors' do
      within 'table' do
        expect(page).to have_content @color.color
      end
    end

    scenario 'user deletes an animal color', js: true do
      within first('tbody tr') do
        expect(page).to have_content @color.color

        page.find(".fa-remove").click
        # page.driver.browser.switch_to.alert.accept # hack for selenium
        # page.driver.browser.accept_js_confirms # hack for webkit
      end
      expect(page).to have_content 'Animal Color was successfully deleted.'
      within first('tbody') do
        expect(page).to_not have_content @color.color
      end
    end

    scenario 'uses pagination' do
      15.times { FactoryGirl.create(:animal_color, organization_id: @user.organization_id, color: 'yolo') }
      visit admin_animal_colors_path
      within first('tbody') do
        expect(page).to_not have_content @color.color
      end

      within '.pagination' do
        click_on '2'
      end

      within first('tbody') do
        expect(page).to have_content @color.color
      end      
    end
  end
end
