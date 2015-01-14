# DadController for all others API Controllers
class API::BaseAPIController < ApplicationController
  before_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token

  def set_access_control_headers
    headers['X-Frame-Options'] = 'ALLOWALL'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['content-type: application/json; charset=utf-8']
  end
end