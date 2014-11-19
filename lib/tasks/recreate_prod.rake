require 'colorize'
require 'factory_girl'
Dir['/spec/factories/*'].each {|file| require file }

namespace :db do
  desc 'Populate PRODUCTION Database'
  task :recreate_prod => :environment do
    puts 'DB prod recreation'.colorize(:yellow)
    Rake::Task['db:drop'].invoke
    puts 'DB creation'.colorize(:blue)
    system('rake db:create RAILS_ENV=production')
    system('rake db:migrate RAILS_ENV=production')
    puts 'DB population'.colorize(:green)
    system('rake db:seed RAILS_ENV=production')
  end
end