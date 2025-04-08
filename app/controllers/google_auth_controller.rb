class GoogleAuthController < ApplicationController
  def redirect_to_google
    client_id = Rails.application.credentials.dig(:GOOGLE, :GOOGLE_CLIENT_ID)
    redirect_uri = "http://localhost:3000/auth/google/callback"
    scope = "https://www.googleapis.com/auth/calendar"

    google_auth_url = "https://accounts.google.com/o/oauth2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&access_type=offline&prompt=consent"

    redirect_to google_auth_url, allow_other_host: true
  end

  def google_callback
    if params[:code]
      render json: { auth_code: params[:code] }
    else
      render json: { error: "Authorization failed" }, status: :unauthorized
    end
  end
end
