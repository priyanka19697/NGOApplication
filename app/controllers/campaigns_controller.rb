class CampaignsController < ApplicationController
  include SessionsHelper

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :logged_in_user, only: [:edit, :update]

  def show
    @campaigns = Campaign.all 
  end

  def donations
    @campaign = Campaign.find(params[:campaign_id])
  end

  def edit
    @user = User.find(params[:user_id])
    @campaign = Campaign.find(params[:campaign_id])

  end

  def create
    @campaign = current_user.campaigns.build(campaign_params)
    @campaign.image.attach(params[:campaign][:image])
    if @campaign.save
      flash[:success] = "campaign created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @campaign.destroy
    flash[:success] = "Campaign deleted"
    redirect_to request.referrer || root_url
  end

  def update
    @user = User.find(params[:id])
    @campaign = Campaign.find(params[:campaign_id])
    if @campaign.update(campaign_params)
      flash[:success] = "donated successfully"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
  def campaign_params
    params.require(:campaign).permit(:content,:duration,:category, :image)
  end

  def correct_user
    @campaign = current_user.campaigns.find_by(id: params[:id])
    redirect_to root_url if @campaign.nil?
  end

  

end
