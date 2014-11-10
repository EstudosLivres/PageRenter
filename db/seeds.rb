# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# CampaignTypes
puts 'Inserting CampaignTypes...'.colorize(:green)
  puts "\t #{CampaignType.find_or_create_by(name: 'link')}"
  puts "\t #{CampaignType.find_or_create_by(name: 'e-commerce')}"
  puts "\t #{CampaignType.find_or_create_by(name: 'marketplace')}"
  puts "\t #{CampaignType.find_or_create_by(name: 'physical_store')}"
puts '...CampaignTypes inserted.'.colorize(:light_blue)
# /CampaignTypes

# Currencies
puts 'Inserting Currencies...'.colorize(:green)
  puts "\t #{Currency.find_or_create_by(name: 'real', acronym: 'R$', iso_code:986)}"
  puts "\t #{Currency.find_or_create_by(name: 'euro', acronym: '€', iso_code:978)}"
  puts "\t #{Currency.find_or_create_by(name: 'american_dollar', acronym: 'US$', iso_code:997)}"
puts '...Currencies inserted.'.colorize(:light_blue)
# /Currencies

# RecurrencePeriods
puts 'Inserting RecurrencePeriods...'.colorize(:green)
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'daily')}"
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'weekly')}"
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'bimonthly')}"
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'quarterly')}"
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'semiannual')}"
  puts "\t #{RecurrencePeriod.find_or_create_by(name: 'annual')}"
puts '...RecurrencePeriods inserted.'.colorize(:light_blue)
# /RecurrencePeriods

# AdStates
puts 'Inserting AdStates...'.colorize(:green)
  puts "\t #{AdState.find_or_create_by(name: 'pending', msg: 'default', description: 'Waiting for PageRenter team inspection')}"
  puts "\t #{AdState.find_or_create_by(name: 'checked', msg: 'warning', description: 'Inspected and it is okay')}"
  puts "\t #{AdState.find_or_create_by(name: 'suspended', msg: 'danger', description: 'Inspected & there is some problem checkout AdHistoryState')}"
  puts "\t #{AdState.find_or_create_by(name: 'running', msg: 'success', description: 'It is able to be public to publishers (paid & there is money from the budget yet)')}"
  puts "\t #{AdState.find_or_create_by(name: 'stopped', msg: 'warning', description: 'Paused by the advertiser owner (not public anymore & budget friezed)')}"
puts '...AdStates inserted.'.colorize(:light_blue)
# /AdStates

# Roles
puts 'Inserting Roles...'.colorize(:green)
  puts "\t #{Role.find_or_create_by(name: 'admin')}"
  puts "\t #{Role.find_or_create_by(name: 'publisher')}"
  puts "\t #{Role.find_or_create_by(name: 'advertiser')}"
puts '...Roles inserted.'.colorize(:light_blue)
# /Roles

# SocialNetworks
puts 'Inserting SocialNetworks...'.colorize(:green)
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Facebook', acronym: 'Face', username: 'facebook', implemented:true, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Twitter', acronym: 'Tw', username: 'twitter', implemented:false, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'YouTube', acronym: 'YT', username: 'youtube', implemented:false, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'GooglePlus', acronym: 'G+', username: 'google-plus', implemented:false, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Instagram', acronym: 'Insta', username: 'instagram', implemented:false, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'FourSquare', acronym: 'FS', username: 'foursquare', implemented:false, just_share:false})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Tumblr', acronym: 'Tb', username: 'tumblr', implemented:false, just_share:true})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Flickr', acronym: 'Fr', username: 'flickr', implemented:false, just_share:true})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Linkedin', acronym: 'in', username: 'linkedin', implemented:false, just_share:true})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Delicious', acronym: 'del', username: 'delicious', implemented:false, just_share:true})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Yahoo', acronym: 'Y!', username: 'yahoo', implemented:false, just_share:true})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Hotmail', acronym: 'Fr', username: 'hotmail', implemented:false, just_share:true})}"
puts '...SocialNetworks inserted.'.colorize(:light_blue)
# /SocialNetworks

# Users
puts 'Inserting PageRenter admins...'.colorize(:green)
  # Root
  u_params = {'role' => 'publisher', 'locale' => 'pt', 'name' => 'PageRenter Admin', 'username' => 'admin', 'email' => 'aa@aa.aa', 'password' => '123'}
  u = User.persist_it(u_params)
  if u.errors.empty?
    # Add as Admin
    u.profiles << Profile.new({name: '', default_role: true, role_id:1})
    u.save
  end

  # Ilton
  u_params = {'role' => 'publisher', 'locale' => 'pt', 'name' => 'Ilton Garcia', 'username' => 'ilton.garcia', 'email' => 'ii@ii.ii', 'password' => '123'}
  u = User.persist_it(u_params)
  if u.errors.empty?
    # Add as Admin
    u.profiles << Profile.new({name: '', default_role: true, role_id:1})
    u.save
  end

  # Willian
  u_params = {'role' => 'publisher', 'locale' => 'pt', 'name' => 'Willian Alves', 'username' => 'wc_calves', 'email' => 'willianccalves@gmail.com', 'password' => '123'}
  u = User.persist_it(u_params)
  if u.errors.empty?
    # Add as Admin
    u.profiles << Profile.new({name: '', default_role: true, role_id:1})
    u.save
  end

  puts "\t #{User.where(email:'admin@pagerenter.com.br')}"
  puts "\t #{User.where(email:'willianccalves@gmail.com')}"
  puts "\t #{User.where(email:'ton.garcia.jr@gmail.com')}"
puts '...PageRenter admins inserted.'.colorize(:light_blue)

puts 'Inserting Publishers...'.colorize(:green)
  puts "\t #{User.persist_it({'role' => 'publisher', 'locale' => 'pt', 'name' => 'Pub Testador', 'username' => 'tst', 'email' => 'pp@pt.pt', 'password' => '123'})}"
  puts "\t #{User.persist_it({'role' => 'publisher', 'locale' => 'en', 'name' => 'Pub Tester', 'username' => 'tster', 'email' => 'pp@en.en', 'password' => '123'})}"
puts '...Publishers inserted.'.colorize(:light_blue)

puts 'Inserting Advertisers...'.colorize(:green)
  puts "\t #{User.persist_it({'role' => 'advertiser', 'locale' => 'pt', 'name' => 'Adv Testador', 'username' => 'adv', 'email' => 'aa@pt.pt', 'password' => '123'})}"
  puts "\t #{User.persist_it({'role' => 'advertiser', 'locale' => 'en', 'name' => 'Adv Tester', 'username' => 'advr', 'email' => 'aa@en.en', 'password' => '123'})}"
puts '...Advertisers inserted.'.colorize(:light_blue)
# /Users