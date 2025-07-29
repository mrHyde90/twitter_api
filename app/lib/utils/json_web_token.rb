module Utils
	class JsonWebToken
		SECRET_KEY = Rails.application.secrets.secret_key_base

		def self.encode(payload, exp = Constants::Users::DEFAULT_EXPIRATION.from_now)
			payload[:exp] = exp.to_i
			JWT.encode(payload, SECRET_KEY)
		end

		def self.decode(token)
			decoded = JWT.decode(token, SECRET_KEY)[0] # [ { "user_id" => 1, "exp" => 1720000000 }, { "alg" => "HS256" } ]
			HashWithIndifferentAccess.new(decoded) # hace que hash con simbolo o string sean iguales
		end
	end
end