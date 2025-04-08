module Mutations
  module Artists
    class DestroyArtist < Mutations::BaseMutation
      description "Destroy artist record"

      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def resolve(id:)
        artist = Artist.find_by_id(id)

        return { success: false, errors: ["Artist not found"]} unless artist

        if artist.destroy
          {
            success: true,
            errors: []
          }
        else
          {
            success: false,
            errors: artist.errors.full_messages
          }
        end
      end
    end
  end
end