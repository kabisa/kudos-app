# frozen_string_literal: true

require "json_web_token"

class AuthToken
  def initialize
    @sekrit = Rails.application.secrets.secret_key_base
    @expiry_hours = Settings.token_expiration_time
  end

  def token(user)
    payload = {
        id: user.id,
        expires_in: (Time.now.utc + @expiry_hours).to_i
    }
    JsonWebToken.sign(payload, key: @sekrit)
  end

  def verify(token)
    payload = decode(token)
    if payload.dig(:ok) && payload.dig(:ok, :expires_in) < Time.now.utc.to_i
      payload = { error: :token_expired }
    end
    payload
  end

  private

    def decode(token)
      JsonWebToken.verify(token, key: @sekrit)
    rescue RuntimeError, ArgumentError => e
      { error: "#{e} (#{e.class.name})" }
    end
end
