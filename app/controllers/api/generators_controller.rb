# All the actions that generate data via GET
class API::GeneratorsController < API::BaseAPIController
  # Custom layouts for specific actions
  layout 'blank', only: [:conversion_tracker]

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

  # TODO if not passed social_network retrieve all links generated? Check login for those actions?
  # Generate the social Links, based on: {:via, :link, :title, :msg, :tags, :img}, it no specific social_network return all generated
  # ex: api/generators/social/share/facebook?title=Titulo&msg=mensagem&img=http://goo.gl/S9eBpV&tags=gitando&via=page&link=http://pagerenter.com.br
  def social
    # Get all params
    link_params = params.permit(:via, :link, :title, :msg, :tags, :img)
    
    # rename keys to be what just share can understand
    link_params[:message] = link_params.delete :msg
    link_params[:hash_tags] = link_params.delete :tags
    link_params[:image_url] = link_params.delete :img
    
    # add it social
    link_params[:social] = params[:social_network]
    render json:  {url_generated: JustShare.on(link_params)}
  end

  # Generate the JSON to help the ConversionTracker
  def conversion_tracker
    # Run it to find the user last access to it URL
    last_access

    # Retrieve it access_hash based on it time_str
    @i = nil
    @most_recent_time_str = @most_recent_time.strftime('%H:%M:%S')
    @accesses_array.each_with_index { |access, i| @i = i unless access.index(@most_recent_time_str).nil? }
    @conversion_hash={}

    unless @i.nil?
      current_access_as_array = @accesses_hash.keys[@i].split('-')

      @conversion_hash = {
          secret:current_access_as_array.last,
          ad_username:current_access_as_array.second,
          publisher_username:current_access_as_array.first
      }
    end

    render 'accesses/conversion_tracker'
  end

  private
    def last_access
      # Base vars
      @accesses_hash = {}
      @accesses_array = []
      @most_recent_time = Time.strptime('00:00:00', '%H:%M:%S')
      @cookie_accesses = cookies[:accesses]

      # Prevent to continue if the access on the cookies are nil
      return if @cookie_accesses.nil?

      @accesses_hash = JSON.parse(@cookie_accesses)
      @accesses_array = @accesses_hash.values

      @accesses_array.each do |access|
        current_time_str = access.split('-').last
        next if current_time_str.nil?
        current_time = Time.strptime(current_time_str, '%H:%M:%S')
        @most_recent_time = current_time if current_time > @most_recent_time
      end

      @most_recent_time
    end
end