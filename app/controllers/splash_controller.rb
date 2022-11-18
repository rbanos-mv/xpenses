class SplashController < ApplicationController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource

  def index
    redirect_to groups_path if user_signed_in?
  end
end
