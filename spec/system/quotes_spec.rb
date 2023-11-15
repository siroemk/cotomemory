# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quotes', type: :system do
  let(:user) { create(:user) }
  let(:child) { create(:child, family: user.family) }

  before do
    sign_in_as(user)
  end

  describe '#index' do
    context 'こどもの情報が1人も登録されていない場合' do
      it '名言一覧にアクセスするとこどもの登録画面が表示されること' do
        visit quotes_path
        expect(current_path).to eq new_child_path
      end
    end

    context '名言が登録されていない場合' do
      it '「まだ名言が登録されていません。」と表示されること' do
        create(:child, family: user.family)
        visit quotes_path
        expect(page).to have_content 'まだ名言が登録されていません。'
      end
    end

    context '名言が登録されている場合' do
      it '登録済みの名言が表示されること' do
        create(:quote, content: 'お金はだいじにつかうんだよ', child:, user:)
        visit quotes_path
        expect(page).to have_content 'お金はだいじにつかうんだよ'
      end
    end

    context '名言を登録したユーザーの場合' do
      it '名言の編集と削除ボタンが表示される' do
        quote = create(:quote, child:, user:)
        visit quotes_path
        expect(page).to have_link('編集', href: "/quotes/#{quote.id}/edit")
        expect(page).to have_link('削除', href: "/quotes/#{quote.id}")
      end
    end

    context '名言を登録していないユーザーの場合' do
      it '名言の編集と削除ボタンが表示されない' do
        quote = create(:quote, child:)
        visit quotes_path
        expect(page).to_not have_link('編集', href: "/quotes/#{quote.id}/edit")
        expect(page).to_not have_link('削除', href: "/quotes/#{quote.id}")
      end
    end
  end

  describe '#show' do
    context '別の家族の名言詳細画面にアクセスした場合' do
      it '「ご指定のページはアクセスできませんでした」と表示されること' do
        other_family_quote = create(:quote)
        visit quote_path(other_family_quote)
        expect(page).to have_content 'ご指定のページはアクセスできませんでした'
      end
    end
  end

  describe '#create' do
    it '名言を登録できること' do
      create(:child, family: user.family)
      visit quotes_path
      click_on '登録する'
      fill_in 'quote[content]', with: 'おかしをいっぱいたべたいな'
      click_on '保存する'
      expect(page).to have_content '名言を登録しました'

      expect(current_path).to eq quotes_path
      expect(page).to have_content 'おかしをいっぱいたべたいな'
    end

    context '名言を入力せずに登録しようとした場合' do
      it '「名言の内容を入力してください」と表示される' do
        create(:child, family: user.family)
        visit quotes_path
        click_on '登録する'
        fill_in 'quote[content]', with: ''
        click_on '保存する'

        expect(page).to have_content '名言の内容を入力してください'
      end
    end
  end

  describe '#edit' do
    it '名言を編集できること' do
      quote = create(:quote, content: '編集前の名言です', child:, user:)
      visit quotes_path
      find("a[href='/quotes/#{quote.id}/edit']").click
      fill_in 'quote[content]', with: '編集後の名言です'
      click_on '保存する'
      expect(page).to have_content '名言を更新しました'

      expect(current_path).to eq quotes_path
      expect(page).to have_content '編集後の名言です'
    end

    context '名言の編集画面でキャンセルを押した場合' do
      it '名言一覧が表示される' do
        quote = create(:quote, content: 'キャンセル前の名言です', child:, user:)
        visit quotes_path
        find("a[href='/quotes/#{quote.id}/edit']").click

        click_on 'キャンセル'
        expect(current_path).to eq quotes_path
        expect(page).to have_content 'キャンセル前の名言です'
      end
    end

    context '別の家族の名言編集画面にアクセスした場合' do
      it '「ご指定のページはアクセスできませんでした」と表示されること' do
        other_family_quote = create(:quote)
        visit edit_quote_path(other_family_quote)
        expect(page).to have_content 'ご指定のページはアクセスできませんでした'
      end
    end
  end

  describe '#destroy' do
    it '名言を削除できること' do
      create(:quote, content: 'おつきさまがついてくるよ', child:, user:)
      visit quotes_path
      expect(page).to have_content 'おつきさまがついてくるよ'

      click_on '削除'
      expect(page.accept_confirm).to eq('本当に削除しますか？')
      expect(page).to have_content '名言を削除しました'

      expect(page).not_to have_content 'おつきさまがついてくるよ'
    end
  end
end
