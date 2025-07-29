module LoggerControllerHelper
	def handle_unexpected(exception)
		message = "#{exception.class.name}: #{exception.message}"
		response = Utils::Jsend::error(message:, code: 'INTERNAL_SERVER_ERROR', data: {})
		render json: response, status: :internal_server_error
	end

	def handle_invalid_data(exception)
		message = exception.message
		response = Utils::Jsend::failure(message:, code: 'invalid_params', data: {})
		render json: response, status: :bad_request
	end

	def handle_exception(exception)
		return handle_unexpected(exception) unless exception.is_a?(Exceptions::BaseServiceException)

		response = exception.to_jsend
		render json: response, status: exception.http_status
	end

	def render_success(data, http_status = :ok, code: 'ok', message: 'ok')
		response = Utils::Jsend::success(data, code:, message:)
		render json: response, status: http_status
	end
end