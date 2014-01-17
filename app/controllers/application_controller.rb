class ApplicationController < ActionController::Base
  protect_from_forgery

  # def after_sign_in_path_for(resource)
  #   sign_in_url = url_for(:action => 'redirector', :controller => 'users', :only_path => false, :method => 'get')
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || root_path
  #   end
  # end
  end
