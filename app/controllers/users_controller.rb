class UsersController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    @user.isOrganizer= false
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      #handle a successful save and show him campaigns page
      redirect_to campaigns_url
    else 
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @campaigns = @user.campaigns
  end

  def donations
    @user = User.find(params[:id])
    # @user.get_my_donations(@user)
    # @user.get_donated_amount(@user)
    # @donations = Donation.where(donor_id:@user.id)
  end

  def funds_from
    @user = User.find(params[:id])
    @user.funds_collected(@user)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
