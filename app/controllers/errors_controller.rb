class ErrorsController < ApplicationController
  def catch_404
    # raise ActionController::RoutingError.new(params[:path])
    render :file => 'public/404.html.erb'
  end

  # Put an Idiom, using the default browse idiom, to the URL
  def redirect
    render :file => 'public/redirect.html.erb'
  end
end
