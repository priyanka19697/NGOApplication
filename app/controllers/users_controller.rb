class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    byebug
    if @user.save
      # byebug
      flash[:success] = "Welcome to the Sample App!"
      #handle a successful save
      redirect_to campaigns_url
    else 
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
