class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @campaign = current_user.campaigns.build 
    else
      redirect_to signup_url
    end
  end

  def about
  end
end
