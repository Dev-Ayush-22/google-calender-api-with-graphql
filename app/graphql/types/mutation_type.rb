# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_artist, mutation: Mutations::Artists::CreateArtist
    field :update_artist, mutation: Mutations::Artists::UpdateArtist
    field :destroy_artist, mutation: Mutations::Artists::DestroyArtist
    field :create_organization, mutation: Mutations::Organization::CreateOrganization
    field :authenticate_google_user, mutation: Mutations::Google::AuthenticateGoogleUser
  end
end
