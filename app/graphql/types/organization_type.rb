module Types
  class OrganizationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :organization_code, String, null: false
    field :token, Types::TokenType, null: false
  end
end
