class ErrorsController < ApplicationController
  def catch_404
    # raise ActionController::RoutingError.new(params[:path])
    render :file => 'public/404.html.erb'
  end
end
