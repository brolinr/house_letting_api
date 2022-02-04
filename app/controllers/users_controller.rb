class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  include CurrentUserConcern

  # Create a User
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :phone, :password, :password_confirmation)
    end
end
