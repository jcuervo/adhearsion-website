require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_uri

  helper :all # include all helpers, all the time

  def check_uri
    redirect_to request.protocol + request.host_with_port[4..-1] + request.request_uri if /^www/.match(request.host)
  end

end
