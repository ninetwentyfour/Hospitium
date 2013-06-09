class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_user!
end