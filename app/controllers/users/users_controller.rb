class UsersController < ApplicationController

  def redirector
    redirect_to '/users/last_fm'
  end

end
