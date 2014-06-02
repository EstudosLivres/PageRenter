class API::ConsoleController < ApplicationController
  layout 'console'

  # Configurations for API Usage;
  def dashboard

  end

  # Documentation about how to use the API;
  def documentation

  end

  private
  def solve_layout
    layout 'home'
    return true
  end
end