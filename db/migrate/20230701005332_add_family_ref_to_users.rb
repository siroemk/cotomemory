class AddFamilyRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :family, null: false, foreign_key: true
  end
end
