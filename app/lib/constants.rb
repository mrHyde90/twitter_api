module Constants
	module Users
		DEFAULT_EXPIRATION = 24.hours
	end

	module Exceptions
		module Codes
			INVALID_CREDENTIALS = 'invalid_credentials'
		  USER_CREATION_FAILED = 'user_creation_failed'
		end

		module Messages
			INVALID_CREDENTIALS = 'Credenciales inválidas'
		end
	end

end