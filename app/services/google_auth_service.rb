require 'google/apis/oauth2_v2'
require 'googleauth'

class GoogleAuthService
  def self.get_valid_access_token(user)
    # If user has no refresh token, they must authenticate first
    return nil if user.google_refresh_token.nil?

    # Use existing token if still valid
    return user.google_access_token unless user.token_expired?

    refresh_access_token(user)
  end

  def self.refresh_access_token(user)
    return nil if user.google_refresh_token.blank? # No refresh token, must re-authenticate

    client_id = Rails.application.credentials.dig(:GOOGLE, :GOOGLE_CLIENT_ID)
    client_secret = Rails.application.credentials.dig(:GOOGLE, :GOOGLE_CLIENT_SECRET)

    client = Signet::OAuth2::Client.new(
      client_id: client_id,
      client_secret: client_secret,
      refresh_token: user.google_refresh_token,
      grant_type: "refresh_token"
    )

    begin
      response = client.fetch_access_token

      if response["access_token"]
        user.update!(
          google_access_token: response["access_token"],
          token_expires_at: Time.current + response["expires_in"].to_i.seconds
        )
        user.google_access_token
      else
        Rails.logger.error "Google token refresh failed: #{response}"
        nil
      end
    rescue StandardError => e
      Rails.logger.error "Error refreshing token: #{e.message}"
      nil
    end
  end
end
