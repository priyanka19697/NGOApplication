class User < ApplicationRecord
  has_many :campaigns, dependent: :destroy
  has_many :given_donations, class_name: "Donation", foreign_key: "donor_id", dependent: :destroy
  has_many :donations, through: :given_donations, source: :campaign

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Campaign.where("user_id = ?", id)
  end

  def get_donated_amount(user)
    @amount = 0
    @donations_made = Donation.where(donor_id:user.id)
    @donations_made.each do |donation|
      if donation.amount != nil
        @amount = @amount + donation.amount
      end
    end
    return @amount
  end

  def funds_collected(user)
    @funds = []
    @campaigns = user.campaigns
    @campaigns.each do |campaign|
      if campaign.funds.count >= 1 
        @funds << campaign.funds
      end
      return @funds
    end
  end

  def funds_collected_from(user)
    @users = []
    @campaigns = user.campaigns
    @campaigns.each do |campaign|
      @donations = Donation.where(campaign_id:campaign.id)
      @donations.each do |donation|
        users = User.all.where(id:donation.donor_id)
        users.each do |single_user|
          user = User.find(single_user.id)
          @users << user
        end
      end
    end
    return @users
  end
    
end
    
  