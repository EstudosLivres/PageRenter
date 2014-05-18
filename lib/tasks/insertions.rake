task :insertions => :environment do
  # Roles
  puts 'Inserting Roles...'.colorize(:green)
  Role.create(name: 'publisher')
  Role.create(name: 'advertiser')
  Role.create(name: 'admin')
  puts '...Roles inserteds.'.colorize(:light_blue)
  # /Roles


end
