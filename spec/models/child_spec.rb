# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Child', type: :model do
  it 'ファクトリが有効であること' do
    child = build(:child)
    expect(child).to be_valid
  end

  context 'こどもの名前が空の場合' do
    it '登録失敗すること' do
      child = build(:child, name: nil)
      child.valid?
      expect(child.errors[:name]).to include('を入力してください')
    end
  end

  context 'こどもの誕生日が空の場合' do
    it '登録失敗すること' do
      child = build(:child, date_of_birth: nil)
      child.valid?
      expect(child.errors[:date_of_birth]).to include('を入力してください')
    end
  end
end
