class DonationsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @campaign = Campaign.find(params[:campaign_id])
    @donation = Donation.create(campaign_id:@campaign.id, donor_id:@user.id,amount: 500)
    @donation.save
    redirect_to donations_user_url(@user.id)
  end
end
