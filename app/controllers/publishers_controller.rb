class PublishersController < ApplicationController
  # Prevent spam USER.FIND on DB
  before_action :setup_user

  def index
  end
end
