# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quote', type: :model do
  it 'ファクトリが有効であること' do
    quote = build(:quote)
    expect(quote).to be_valid
  end

  context '名言が空の場合' do
    it '登録失敗すること' do
      quote = build(:quote, content: nil)
      quote.valid?
      expect(quote.errors[:content]).to include('を入力してください')
    end
  end
end
