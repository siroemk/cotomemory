class ChangeDataInvitationTokenToFamily < ActiveRecord::Migration[7.0]
  def change
    change_column :families, :invitation_token, :string
  end
end
