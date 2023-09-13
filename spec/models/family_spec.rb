# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Family', type: :model do
  it 'ファクトリが有効であること' do
    family = build(:family)
    expect(family).to be_valid
  end

  context 'invitation_tokenが空の場合' do
    it '登録失敗すること' do
      family = build(:family, invitation_token: nil)
      family.valid?
      expect(family.errors[:invitation_token]).to include('を入力してください')
    end
  end
end
