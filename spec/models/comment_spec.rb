# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  it 'ファクトリが有効であること' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  context 'コメントが空の場合' do
    it '登録失敗すること' do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end
  end

  context 'quoteが空の場合' do
    it '登録失敗すること' do
      comment = build(:comment, quote: nil)
      comment.valid?
      expect(comment.errors[:quote]).to include('を入力してください')
    end
  end

  context 'userが空の場合' do
    it '登録失敗すること' do
      comment = build(:comment, user: nil)
      comment.valid?
      expect(comment.errors[:user]).to include('を入力してください')
    end
  end
end
