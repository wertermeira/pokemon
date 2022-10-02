# frozen_string_literal: true

class JwtToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base.to_s)
    end

    def decode(token)
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base.to_s)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end
