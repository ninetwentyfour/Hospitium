class Admin::PostsController < Admin::CrudController
  load_and_authorize_resource
  
end
