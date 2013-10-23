class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :add_flash_to_header
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def add_flash_to_header
    # only run this in case it's an Ajax request.

    #hello = request.inspect

    #puts "before return in flash, and #{request.xhr?} and #{hello}"
    return unless request.xhr?


    # add different flashes to header
    response.headers['X-Flash-Error'] = flash[:error] unless flash[:error].blank?
    response.headers['X-Flash-Alert'] = flash[:alert] unless flash[:alert].blank?
    response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
    response.headers['X-Flash-Message'] = flash[:success] unless flash[:success].blank?


    # make sure flash does not appear on the next page
    flash.discard

  end

  protected



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :phone]
  end


end
