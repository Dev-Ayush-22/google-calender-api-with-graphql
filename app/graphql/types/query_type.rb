# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :items, resolver: Queries::Items
    field :item, resolver: Queries::Item
    field :artists, resolver: Queries::Artists
    field :organization, resolver: Queries::Organization

  end
end