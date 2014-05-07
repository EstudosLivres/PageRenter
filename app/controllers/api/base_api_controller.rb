# DadController for all others API Controllers
class API::BaseAPIController < ApplicationController
  before_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['content-type: application/json; charset=utf-8']
  end

end