class Campaign < ApplicationRecord
  belongs_to :user
  has_many :recieved_funds, class_name: "Donation", foreign_key: "campaign_id", dependent: :destroy
  has_many :funds, through: :recieved_funds, source: :donor
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :category, presence: true, length: { maximum: 20 }
  validates :image, content_type: {in: %w[image/jpeg image/gif image/png], 
  message: "must be a valid image format"},
  size: {less_than: 5.megabytes,
  message: "should be less than 5MB"}

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def get_funds_recieved(campaign)
    @my_funds = Donation.all.where(campaign_id:campaign.id)
  end
end
