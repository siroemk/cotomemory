# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Top', type: :system do
  let(:user) { create(:user) }

  describe '#index' do
    context 'ログインしていないユーザーが/にアクセスした場合' do
      it 'ログイン前のトップ画面が表示されること' do
        visit root_path
        expect(page).to have_content('こどもの面白い名言を記録しよう')
      end

      it 'ハンバーガーメニューが表示されないこと' do
        visit root_path
        expect(page).to have_no_css '.navbar'
      end
    end

    context 'ログインしているユーザーが/にアクセスした場合' do
      it '名言一覧が表示されること' do
        create(:child, family: user.family)
        sign_in_as(user)
        visit root_path
        expect(current_path).to eq quotes_path
      end

      it 'ハンバーガーメニューが表示されること' do
        sign_in_as(user)
        visit root_path
        expect(page).to have_css '.navbar'
      end
    end
  end

  describe '#welcome' do
    context 'ログインしていないユーザーが招待URLにアクセスした場合' do
      it '招待ページが表示される' do
        visit "http://127.0.0.1/welcome?invitation_token=#{user.family.invitation_token}"
        expect(page).to have_content '家族から招待されています'
        expect(current_path).to eq welcome_path
      end
    end

    context 'ログインしているユーザーが招待URLにアクセスした場合' do
      it '名言一覧が表示される' do
        create(:child, family: user.family)
        sign_in_as(user)
        visit "http://127.0.0.1/welcome?invitation_token=#{user.family.invitation_token}"
        expect(current_path).to eq quotes_path
      end
    end
  end
end
