class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.integer :invitation_token, null: false

      t.timestamps
    end
  end
end
