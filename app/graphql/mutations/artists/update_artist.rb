module Mutations
  module Artists
    class UpdateArtist < Mutations::BaseMutation
      description "Update artist record"
      type Types::ArtistType, null: false

      argument :id, ID, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :email, String, required: false

      field :artist, Types::ArtistType, null: true
      field :errors, [String], null: false

      def resolve(id:, **attributes)
        artist = Artist.find_by_id(id)
        return { artist: nil, errors: ["Artist not found"]} unless artist

        if artist.update(attributes.compact)
          {
            artist: artist,
            errors: []
          }
        else
          {
            artist: nil,
            errors: artist.errors.full_messages
          }
        end
      end
    end
  end
end