class API::GeneratorController < API::BaseAPIController
  # Generate shorter link from the link passed as param & persist it
  def shorter
    # Fabricate a shorter
    shorter = ShorterLink.fabricate_with params[:url], params[:ad_username], params[:pub_username]

    # If there is any error process it
    shorter.errors.messages.delete(:link) unless shorter.errors.messages[:link].first.index('taken').nil? unless shorter.errors.empty?

    # Abort if Publisher or Ad not found (prevent to consume Shorter)
    success_msg = 'A URL requisitada foi encurtada com sucesso!'.to_get_param
    error_msg = 'Ocorreu algum erro ao tentar encurtar a URL requisitada!'.to_get_param
    shorter.errors.empty? ? redirect_to("#{publisher_root_url}?success=#{success_msg}") : redirect_to("#{publisher_root_url}?error=#{error_msg}")
  end
end