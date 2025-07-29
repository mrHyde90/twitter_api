class ApplicationController < ActionController::API
	include LoggerControllerHelper

  rescue_from StandardError, with: :handle_unexpected
  rescue_from Exceptions::BaseServiceException, with: :handle_exception
	rescue_from ArgumentError, with: :handle_invalid_data
end
