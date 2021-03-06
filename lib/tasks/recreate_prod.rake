require 'colorize'

namespace :db do
  desc 'Populate PRODUCTION Database'
  task :recreate_prod => :environment do
    puts 'DB prod recreation'.colorize(:yellow)
    Rake::Task['db:drop RAILS_ENV=production'].invoke
    puts 'DB creation'.colorize(:blue)
    system('rake db:create RAILS_ENV=production')
    system('rake db:migrate RAILS_ENV=production')
    puts 'DB population'.colorize(:green)
    system('rake db:seed RAILS_ENV=production')
  end
end