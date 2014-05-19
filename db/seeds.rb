# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Roles
puts 'Inserting Roles...'.colorize(:green)
Role.create(name: 'publisher')
Role.create(name: 'advertiser')
Role.create(name: 'admin')
puts '...Roles inserteds.'.colorize(:light_blue)
# /Roles

# SocialNetworks
puts 'Inserting SocialNetworks...'.colorize(:green)
SocialNetwork.create(name: 'Facebook', acronym: 'Face')
SocialNetwork.create(name: 'Twitter', acronym: 'Tw')
SocialNetwork.create(name: 'GooglePlus', acronym: 'G+')
SocialNetwork.create(name: 'Tumbler', acronym: 'Tb')
SocialNetwork.create(name: 'Flicker', acronym: 'Fr')
puts '...SocialNetworks inserteds.'.colorize(:light_blue)
# /SocialNetworks