require 'rest-client'
require 'populate/accesses'

namespace :populate do
  desc "Populate accesses table, to be easier to generate Charts"
  task accesses: :environment do
    # Base URLs
    base_url = 'http://localhost:4000/publishers/accesses/PaginaNoPainNoGain/'
    odd_path = 'tempo-concurso'
    even_path = 'tempo-gerenciar-financas'

    # URLs with it paths
    odd_url = "#{base_url+odd_path}"
    even_url = "#{base_url+even_path}"

    # How much time
    amount = 150

    # The loop
    amount.times do |i|
      # setup the current url which will be requested
      current_url = even_url if i%2==0
      current_url = odd_url if i%2!=0

      resp = RestClient.get current_url
      puts resp.code
    end

    # UPDATE ACCESSES to have reccurent
    Populate::Accesses.update_loop(2, 15)
    Populate::Accesses.update_loop(10, 32)
    Populate::Accesses.update_loop(5, 55)
    Populate::Accesses.update_loop(5, 85)
    Populate::Accesses.update_loop(5, 90)
  end
end
