module API::Concerns
  class TokenManager
    extend ActiveSupport::Concern
    @email
    @password
    @user_hash
    @user_id
    @usuario_corrente
    @token
    @crypt_count = 0

    def initialize email, password, access_token
      @email = email
      @password = password
      unless access_token.nil? then @token = access_token end
      generate_token
    end

    def token
      @token
    end

    def generate_token
      valida_usuario
      if !@token.has_key?('erro') then registra_acesso end
    end

    def valida_usuario
      # "#{$!}"
      token_erro = { 'erro'=> "Login ou Senha inválido" }

      # Try/Catch para ver se o Usuário foi encontrado no BD
      begin
        return @token = token_erro if  (@token.nil? && (@password.nil? || @email.nil?))
        if @token.nil? then @usuario_corrente = User.authenticate(@email, @password) else @usuario_corrente = User.where(access_token: @token).take! end
        @user_hash = @usuario_corrente.attributes
        @user_id = @user_hash['id']
        return @token = token_erro if @user_id.nil?
        # SE SEM PERMISSAO: return @token = { 'erro'=>'Você não tem permissão de Vistoriador' } if @usuario_corrente.role_id != 4
        @token = { 'access_token'=> @user_hash['access_token'] }
      rescue
        @token = token_erro
        return @token
      end
    end

    def registra_acesso
      # O Registro de Acesso execute o Registro de token
      if visita_recorrente? then
        return @token = encripta_token
      else
        @token = encripta_token
        # Verifico se já tem um token com aquele Hast para evitar duplicidade de Login
        reencripta_token if User.where(access_token: @token['access_token']).count >= 1
        @usuario_corrente.update(access_token: @token['access_token'])
      end
    end

    def visita_recorrente?
      !@token['access_token'].nil?
    end

    def encripta_token
      @token = { 'access_token'=> Digest::MD5.hexdigest("#{@email}:#{@password}").to_s }
    end

    def reencripta_token
=begin
      @crypt_count = @crypt_count + 1
      @token = @token + @crypt_count
      registra_acesso
=end
    end

    def current_user
      @usuario_corrente
    end
  end
end