module Utils
	class Jsend
		class << self
			def success(data, code: nil, message: nil)
				code ||= 'ok'
				{
					status: 'success',
					code: code&.downcase,
					message: message || 'ok',
					data:
				}
			end

			def failure(message:, code: nil, data: nil)
				code ||= 'bad_request'
				{
					status: 'fail',
					code: code&.downcase,
					message:,
					data:
				}
			end

			def error(message:, code: nil, data: nil)
				code ||= 'INTERNAL_SERVER_ERROR'
				{
					status: 'error',
					code: code&.downcase,
					message:,
					data:
				}
			end

		end
	end
end