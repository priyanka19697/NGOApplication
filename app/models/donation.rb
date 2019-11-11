class Donation < ApplicationRecord
    
    belongs_to :donor, class_name: "User"
    belongs_to :campaign, class_name: "Campaign"
    
end
