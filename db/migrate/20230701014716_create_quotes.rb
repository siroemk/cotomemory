class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
