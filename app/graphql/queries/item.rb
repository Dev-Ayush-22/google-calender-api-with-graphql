module Queries
  class Item < Queries::BaseQuery
    description "Return a single record"

    argument :id, ID, required: false

    argument :artist_id, Integer, required: false

    type Types::ItemType, null: true

    def resolve(id: nil, artist_id: nil)
      ::Item.find_by(arguments)
    end
    
  end
end