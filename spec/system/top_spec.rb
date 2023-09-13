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
  end
end
