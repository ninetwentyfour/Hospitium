module FeatureMacros
  def new_logged_in_user
    user = FactoryGirl.create(:user)
    user.roles << FactoryGirl.create(:role)
    user.confirm
    login_as user
    user
  end

  def existing_logged_in_user
    user = FactoryGirl.create(:user)
    user.roles << FactoryGirl.create(:role)
    user.confirm

    # create some related data for this user/org
    FactoryGirl.create(:animal, organization_id: user.organization_id)
    FactoryGirl.create(:species, organization_id: user.organization_id)
    FactoryGirl.create(:foster_contact, organization_id: user.organization_id)

    login_as user
    user
  end

  def change_bip_text(attribute, new_value)
    page.find("span[data-attribute='#{attribute}']").click
    within "span[data-attribute='#{attribute}']" do
      fill_in attribute, with: new_value
      # if using selnium you have to do this
      # page.find("input").set new_value
      # page.find('input').native.send_keys(:return)
    end
  end
end
