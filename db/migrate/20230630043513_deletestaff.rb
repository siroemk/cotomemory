class Deletestaff < ActiveRecord::Migration[7.0]
  def change
    drop_table :staff
  end
end
