# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# AdStates
puts 'Inserting AdStates...'.colorize(:green)
puts "\t #{AdState.find_or_create_by(name: 'stopped')}"
puts "\t #{AdState.find_or_create_by(name: 'running')}"
puts "\t #{AdState.find_or_create_by(name: 'pending')}"
puts "\t #{AdState.find_or_create_by(name: 'checked')}"
puts "\t #{AdState.find_or_create_by(name: 'suspended')}"
puts '...AdStates inserted.'.colorize(:light_blue)
# /AdStates

# Currencies
puts 'Inserting Currencies...'.colorize(:green)
puts "\t #{Currency.find_or_create_by(name: 'Real', acronym: 'R$')}"
puts "\t #{Currency.find_or_create_by(name: 'Euro', acronym: '€')}"
puts "\t #{Currency.find_or_create_by(name: 'Dólar Americano', acronym: 'US$')}"
puts '...Currencies inserted.'.colorize(:light_blue)
# /Currencies

# Roles
puts 'Inserting Roles...'.colorize(:green)
  puts "\t #{Role.find_or_create_by(name: 'admin')}"
  puts "\t #{Role.find_or_create_by(name: 'publisher')}"
  puts "\t #{Role.find_or_create_by(name: 'advertiser')}"
puts '...Roles inserted.'.colorize(:light_blue)
# /Roles

# SocialNetworks
puts 'Inserting SocialNetworks...'.colorize(:green)
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Facebook', acronym: 'Face'})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Twitter', acronym: 'Tw'})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'GooglePlus', acronym: 'G+'})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Tumbler', acronym: 'Tb'})}"
  puts "\t #{SocialNetwork.find_or_create_by({name: 'Flicker', acronym: 'Fr'})}"
puts '...SocialNetworks inserted.'.colorize(:light_blue)
# /SocialNetworks

# Users
puts 'Inserting Publishers...'.colorize(:green)
  puts "\t #{User.persist_it({'role' => 'publisher', 'locale' => 'pt', 'name' => 'Pub Testador', 'username' => 'tst', 'email' => 'pp@pt.pt', 'password' => '123'})}"
  puts "\t #{User.persist_it({'role' => 'publisher', 'locale' => 'en', 'name' => 'Pub Tester', 'username' => 'tster', 'email' => 'pp@en.en', 'password' => '123'})}"
puts '...Publishers inserted.'.colorize(:light_blue)

puts 'Inserting Advertisers...'.colorize(:green)
  puts "\t #{User.persist_it({'role' => 'advertiser', 'locale' => 'pt', 'name' => 'Adv Testador', 'username' => 'adv', 'email' => 'aa@pt.pt', 'password' => '123'})}"
  puts "\t #{User.persist_it({'role' => 'advertiser', 'locale' => 'en', 'name' => 'Adv Tester', 'username' => 'advr', 'email' => 'aa@en.en', 'password' => '123'})}"
puts '...Advertisers inserted.'.colorize(:light_blue)
# /Users