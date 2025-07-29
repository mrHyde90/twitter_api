module Services
	class AuthenticationService
		class << self

			def login(params)
				user = User.find_by(email: params[:email])

				if user&.authenticate(params[:password])
					response = get_token_and_expiration_date(user.id)
					return response
				else
					raise_error(
						Constants::Exceptions::Messages::INVALID_CREDENTIALS,
						Constants::Exceptions::Codes::INVALID_CREDENTIALS,
						:unauthorized
					)
				end
			end

			def signup(params)
				user = User.new(params)
				if user.save 
					token, expires_at = get_token_and_expiration_date(user.id).values_at(:token, :expires_at)
					return { user:, token:, expires_at: }
				else
					raise_error(
						user.errors.full_messages, 
						Constants::Exceptions::Codes::USER_CREATION_FAILED,
						:unprocessable_entity
					)
				end
			end


			private
			  def get_token_and_expiration_date(user_id)
					token = Utils::JsonWebToken.encode(user_id:)
					expires_at = Constants::Users::DEFAULT_EXPIRATION.from_now.to_i
					{
						token:,
						expires_at:
					}
				end

				def raise_error(message, code, status)
					raise Exceptions::BaseServiceException.new(message, code:, http_status: status)
				end

		end
	end
end