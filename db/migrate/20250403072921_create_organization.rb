class CreateOrganization < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :organization_code

      t.timestamps
    end
  end
end