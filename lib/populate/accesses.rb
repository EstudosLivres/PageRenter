module Populate
  class Accesses
    # Method to Update specific recurrent amounts
    def self.update_loop limit, offset
      accesses = Access.where(recurrent:0).limit(limit).offset(offset)
      accesses.each do |access|
        access.update(recurrent:true)
      end
    end
  end
end