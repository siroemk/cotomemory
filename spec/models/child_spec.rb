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

  context 'こどもの名前が16文字以上の場合' do
    it '登録失敗すること' do
      child = build(:child, name: 'a' * 15)
      child.valid?
      expect(child.errors[:name]).not_to include('は15文字以内で入力してください')

      child = build(:child, name: 'a' * 16)
      child.valid?
      expect(child.errors[:name]).to include('は15文字以内で入力してください')
    end
  end

  context 'こどもの誕生日が空の場合' do
    it '登録失敗すること' do
      child = build(:child, date_of_birth: nil)
      child.valid?
      expect(child.errors[:date_of_birth]).to include('を入力してください')
    end
  end

  context 'familyが空の場合' do
    it '登録失敗すること' do
      child = build(:child, family: nil)
      child.valid?
      expect(child.errors[:family]).to include('を入力してください')
    end
  end
end
