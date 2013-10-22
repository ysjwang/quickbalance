class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :add_flash_to_header

  def add_flash_to_header
    # only run this in case it's an Ajax request.
    return unless request.xhr?

    # add different flashes to header
    response.headers['X-Flash-Error'] = flash[:error] unless flash[:error].blank?
    response.headers['X-Flash-Alert'] = flash[:alert] unless flash[:alert].blank?
    response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
    response.headers['X-Flash-Message'] = flash[:success] unless flash[:success].blank?

    # make sure flash does not appear on the next page
    flash.discard
  end
end
