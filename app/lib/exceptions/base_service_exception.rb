module Exceptions
	class BaseServiceException < StandardError
		attr_reader :http_status, :data, :code

		def initialize(message = nil, code: nil, data: nil, title: nil, http_status: 500)
			super(message || 'Unexpected Error on Service')
			@title = title || self.class.name
			@code = code
			@data = data
			@http_status = http_status
		end

		def to_jsend
			case http_status
			when 200..299
				Utils::Jsend::success(data, code:, message:)
			when 400..499
				Utils::Jsend::failure(message:, code:, data:)
			else
				Utils::Jsend::error(message:, code:, data:)
			end
		end
	end
end