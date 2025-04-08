require 'google/apis/oauth2_v2'
require 'googleauth'
require 'json'

module Mutations
  module Google
    class AuthenticateGoogleUser < Mutations::BaseMutation
      argument :auth_code, String, required: true
      argument :organization_code, String, required: true

      field :organization, Types::OrganizationType, null: true
       field :token, Types::TokenType, null: true
      field :error, [String], null: true

      def resolve(auth_code:, organization_code:)
        
        current_organization = ::Organization.find_by(organization_code: organization_code)
        return { organization: nil, token: nil, error: ["Organization not found"] } unless current_organization

        json_key = JSON.parse(File.read("client_secret.json"))
        existing_refresh_token = current_organization.token.present? ? current_organization.token.refresh_token : ""
        credentials = ::Google::Auth::UserRefreshCredentials.new(
          client_id: json_key["web"]["client_id"],
          client_secret: json_key["web"]["client_secret"],
          token_credential_uri: json_key["web"]["token_uri"],
          scope: ['https://www.googleapis.com/auth/calendar'],
          code: auth_code,
          redirect_uri: json_key["web"]["redirect_uris"].first,
          refresh_token:  existing_refresh_token
        )



        begin
          response = credentials.fetch_access_token

          unless response["access_token"]
            return { error: ["Failed to retrieve access token from Google"] }
          end



          # Update/Create organization tokens 
          token = current_organization.token || current_organization.build_token

          token.assign_attributes(
            source: "Google",
            access_token: response["access_token"],
            refresh_token: response["refresh_token"] || token.refresh_token,
            expires_at: Time.current + response["expires_in"].to_i.seconds
          )

          if token.save!
            { organization: current_organization, token: token }
          else
            { error: token.errors.full_messages, organization: nil, token: nil }
          end

        rescue Signet::AuthorizationError => e
          Rails.logger.error "Google OAuth Authorization Error: #{e.message}"
          { error: ["Invalid authorization code"], organization: nil, token: nil }
        rescue StandardError => e
          Rails.logger.error "Google OAuth Unexpected Error: #{e.message}"
          { error: ["An unexpected error occurred. Please try again."], organization: nil, token: nil }
        end
      end
    end
  end
end
