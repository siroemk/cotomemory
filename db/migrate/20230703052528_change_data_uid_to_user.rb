class ChangeDataUidToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :uid, :string
    change_column :users, :provider, :string
  end
end
