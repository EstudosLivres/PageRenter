module RailsFixes
  class Util
    extend ActiveSupport::Concern

    # Convert action controller into hash
    def self.action_controller_to_hash(action_controller)
      return nil if action_controller.nil?
      return_hash = {}

      # Foreach the Actionc ontroller keys (converting to symbol & saving each value)
      action_controller.each {|key, value| return_hash[key.to_sym] = value}

      return_hash
    end

    # Convert string keys to symbol keys
    def self.hash_keys_to_sym(hash_string_keys)
      hash_string_keys.keys.each do |key|
        hash_string_keys[(key.to_sym rescue key) || key] = hash_string_keys.delete(key)
      end

      return hash_string_keys
    end
  end
end