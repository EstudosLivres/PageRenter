module Model::Concerns
  class Util
    extend ActiveSupport::Concern

    # Convert action controller into hash
    def self.action_controller_to_hash action_controller
      return nil if action_controller.nil?
      return_hash = {}

      # Foreach the Actionc ontroller keys (converting to symbol & saving each value)
      action_controller.each {|key, value| return_hash[key.to_sym] = value}

      return_hash
    end
  end
end