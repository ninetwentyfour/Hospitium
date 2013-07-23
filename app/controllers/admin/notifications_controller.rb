class Admin::NotificationsController < Admin::CrudController
  load_and_authorize_resource

  # Allowed params for create and update
  self.permitted_attrs = [:message, :status_type]
  # scope create to current_user.organization
  self.save_as_organization = false
end
