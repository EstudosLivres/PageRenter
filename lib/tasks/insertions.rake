task :insertions => :environment do
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
end
