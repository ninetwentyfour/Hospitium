class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_user!
  layout :set_layout

  #render the admin layout if not a pjax request
  private
    def set_layout
      if request.headers['X-PJAX']
        false
      else
        "admin/application"
      end
    end
end