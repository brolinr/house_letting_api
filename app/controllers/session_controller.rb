#all we need to do is to search for the user w
#e want and store his id so we can use it when we create a property

class SessionsController < ApplicationController
  include CurrentUserConcern
  
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
    else
      render json: 'Invalid email/password combination', status: :unprocessable_entity
    end
  end
end