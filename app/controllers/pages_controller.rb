class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
     @services = policy_scope(Service)
     @user = current_user
  end
end
