class Admin::PostsController < Admin::CrudController
  load_and_authorize_resource

  # Allowed params for create and update
  self.permitted_attrs = [:author, :title, :content]
  # scope create to current_user.organization
  self.save_as_organization = false
end