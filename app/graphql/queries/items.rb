module Queries
  class Items < Queries::BaseQuery
    description "Return a list of items"
    type [Types::ItemType], null: true

    argument :id, [ID], required: false

    def resolve(id: nil)
      ::Item.where(arguments)
    end
    
  end
end