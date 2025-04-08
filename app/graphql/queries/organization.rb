module Queries
  class Organization < Queries::BaseQuery
    description "Return a Organization"
    argument :id, [ID], required: false
    type Types::OrganizationType, null: true

    def resolve(id: nil)
      organization = ::Organization.find_by(arguments)
    end
    
  end
end