class UsersController < ApplicationController
  def feed
    redirect_to root_path if current_user == nil  
  end
end
