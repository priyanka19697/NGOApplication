class DonationsController < ApplicationController
  def new
    @user = User.new
    @campaign = Campaign.find(params[:campaign_id])
  end

  def create
    @user = User.find(params[:user_id])
    @campaign = Campaign.find(params[:campaign_id])
    @donation = Donation.create(campaign_id:@campaign.id, donor_id:@user.id,amount: params[:campaign][:amount].to_i)
    @donation.save
    redirect_to donations_user_url(@user.id)
  end
  
  # private
  # def donation_params
  #   params.require([:campaign][:amount]).permit(:campaign_id, :donor_id)
  # end
end
