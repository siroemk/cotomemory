# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { create(:user) }
  let(:child) { create(:child, family: user.family) }
  let(:quote) { create(:quote, child:, user:) }

  before do
    sign_in_as(user)
  end

  describe '#create' do
    it 'コメントを登録できること' do
      visit quote_path(quote)
      fill_in 'comment[content]', with: '面白いこと言うね'
      click_on '送信'
      expect(page).to have_content 'コメントしました'
      expect(page).to have_content '面白いこと言うね'
    end

    context 'コメントを入力せずに登録しようとした場合' do
      it '「コメントの内容を入力してください」と表示される' do
        visit quote_path(quote)
        fill_in 'comment[content]', with: ''
        click_on '送信'
        expect(page).to have_content 'コメントの内容を入力してください'
      end
    end
  end

  describe '#destroy' do
    it 'コメントを削除できること' do
      comment = create(:comment, content: '削除されるコメントです', user:, quote:)
      visit quote_path(quote)

      within("#comment_#{comment.id}") do
        click_on '削除'
      end

      expect(page.accept_confirm).to eq('本当に削除しますか？')
      expect(page).to have_content 'コメントを削除しました'
      expect(page).to_not have_content '削除されるコメントです'
    end

    context '自分が投稿したコメントでない場合' do
      it '削除ボタンは表示されない' do
        comment = create(:comment, content: 'そんなことを話すんだね', quote:)
        visit quote_path(quote)

        within("#comment_#{comment.id}") do
          expect(page).to_not have_content '削除'
        end
      end
    end
  end
end
