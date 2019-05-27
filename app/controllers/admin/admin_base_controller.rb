class Admin::AdminBaseController < ApplicationController
  before_action :admin_user
  include UsersHelper
end
