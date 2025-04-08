class CreateTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.string :source
      t.references :organization, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
