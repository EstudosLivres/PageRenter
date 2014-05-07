# Concern to create JSONs for Syncs
module API::Concerns
  class Sync
    extend ActiveSupport::Concern

    # Inicializador do JSON de retorno
    def initialize remote_user
      @remote_user = remote_user
    end

  end
end
