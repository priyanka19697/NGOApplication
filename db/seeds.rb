# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a main sample user.
User.create!(name: "Example User",
    email: "example@railstutorial.org",
    password: "foobar",
    password_confirmation: "foobar",
    isOrganizer: false)
    # Generate a bunch of additional users.
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password,
      isOrganizer:false)
    end

   # Generate campaigns for a subset of users.
   users = User.order(:created_at).take(6)
   5.times do
    content = Faker::Lorem.sentence(word_count: 5)
    duration = Faker::Name.name
    category = "miscallaneous"
    users.each { |user| user.campaigns.create!(content: content, duration: duration, category: category) }
   end

   #create donations, funds

   users = User.all 
   campaigns = Campaign.all
   user = users.first
   campaign = campaigns.first
   donations_to = campaigns[1...25]
   funds_from = users[1...5]
  #  donations_to.each {|campaign| user.donate(campaign,user,500)}
  #  funds_from.each{|donor| campaign.get_fund(campaign,donor,500)}

  #make first five donate to first five campaigns
  funds_from.each{|user| 
    donations_to.each{|campaign|
      user.donate(campaign,user,500)
  }
}

# funds_from.each{|user| 
#   campaigns = user.campaigns
#   campaigns.each {|campaign| 
#     campaign.get_fund(campaign,user,500)
#   }
# }


    
  
