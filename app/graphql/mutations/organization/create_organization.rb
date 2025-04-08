module Mutations
  module Organization
    class CreateOrganization < Mutations::BaseMutation
      argument :name, String, required: true
      argument :organization_code, String, required: true

      field :organization, Types::OrganizationType, null: false
      field :errors, [String], null: false

      def resolve(name:, organization_code:)
        organization = ::Organization.new(arguments)
        if organization.save
          {
            organization: organization,
            errors: []
          }
        else
          {
            organization: nil,
            errors: organization.errors.full_messages
          }
        end
      end
    end
  end
end