class RedirController < ApplicationController
  layout :solve_layout

  def index
  end

  private
  def solve_layout
    'blank_redir'
  end
end
