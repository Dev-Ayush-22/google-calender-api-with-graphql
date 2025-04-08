module Types
  class TokenType < Types::BaseObject
    field :id, ID, null: false
    field :access_token, String, null: false
    field :refresh_token, String, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
    field :organization_id, ID, null: false
  end
end
