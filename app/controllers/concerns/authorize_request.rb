module AuthorizeRequest
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?

    decoded = Utils::JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError, JWT::ExpiredSignature => e
    Rails.logger.warn("JWT decode failed: #{e.message}")
    render json: { errors: ['No autorizado'] }, status: :unauthorized
  end
end
