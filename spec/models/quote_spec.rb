# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quote', type: :model do
  it 'ファクトリが有効であること' do
    quote = build(:quote)
    expect(quote).to be_valid
  end

  context '名言が501文字以上の場合' do
    it '登録失敗すること' do
      quote = build(:quote, content: 'a' * 500)
      quote.valid?
      expect(quote.errors[:content]).not_to include('は500文字以内で入力してください')

      quote = build(:quote, content: 'a' * 501)
      quote.valid?
      expect(quote.errors[:content]).to include('は500文字以内で入力してください')
    end
  end

  context '名言が空の場合' do
    it '登録失敗すること' do
      quote = build(:quote, content: nil)
      quote.valid?
      expect(quote.errors[:content]).to include('を入力してください')
    end
  end

  context 'userが空の場合' do
    it '登録失敗すること' do
      quote = build(:quote, user: nil)
      quote.valid?
      expect(quote.errors[:user]).to include('を入力してください')
    end
  end

  context 'childが空の場合' do
    it '登録失敗すること' do
      quote = build(:quote, child: nil)
      quote.valid?
      expect(quote.errors[:child]).to include('を入力してください')
    end
  end
end
