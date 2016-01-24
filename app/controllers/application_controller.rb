class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception

  # before_action :set_headers

  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  private

  # def set_headers
  #   headers['Access-Control-Allow-Credentials'] = 'true'
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Origin'] = 'http://localhost:3000/'
  #   # headers['Access-Control-Allow-Origin'] = 'http://localhost:3002/'
  #   headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS, PUT, PATCH, DELETE'
  #   headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type'
  #   headers['Access-Control-Max-Age'] = "1728000"
  #   #
  #   # headers['Access-Control-Allow-Origin'] = '*'
  #   #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   #   headers['Access-Control-Max-Age'] = "1728000"
  # end

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    # headers['Access-Control-Allow-Origin'] = 'localhost'
    headers['Access-Control-Allow-Origin'] = 'http://localhost'
    # headers['Access-Control-Allow-Origin'] = 'http://localhost:3000/'
    # headers['Access-Control-Allow-Origin'] = 'http://localhost:3002/'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS, PUT, PATCH, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"

  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Expose-Headers'] = 'ETag'
  #   headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
  #   headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
  #   headers['Access-Control-Max-Age'] = '86400'
  # end

  # before_action :cors_preflight_check
  # after_filter :cors_set_access_control_headers
  #
  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   headers['Access-Control-Max-Age'] = "1728000"
  # end
  #
  # def cors_preflight_check
  #   if request.method == 'OPTIONS'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
  #     headers['Access-Control-Max-Age'] = '1728000'
  #
  #     render :text => '', :content_type => 'text/plain'
  #   end
  # end

end
