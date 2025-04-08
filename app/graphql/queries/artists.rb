module Queries
  class Artists < Queries::BaseQuery
    description "Return a list of Artists"
    type [Types::ArtistType], null: true

    argument :id, [ID], required: false

    def resolve(id: nil)
      ::Artist.where(arguments)
    end
    
  end
end