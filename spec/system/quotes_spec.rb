# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quotes', type: :system do
  let(:user) { create(:user) }
  let(:my_child) { create(:child, family: user.family) }
  before do
    sign_in_as(user)
  end

  it '名言を登録できること' do
    create(:child, family: user.family)
    visit quotes_path
    click_on '登録する'
    fill_in 'quote[content]', with: 'テストの名言です'
    click_on '保存する'
    expect(page).to have_content '名言を登録しました'

    expect(current_path).to eq quotes_path
    expect(page).to have_content 'テストの名言です'
  end

  it '名言を編集できること' do
    create(:quote, child: my_child, user:)
    visit quotes_path
    click_on '編集'
    fill_in 'quote[content]', with: '今日もがんばりたい'
    click_on '保存する'
    expect(page).to have_content '名言を更新しました'

    expect(current_path).to eq quotes_path
    expect(page).to have_content '今日もがんばりたい'
  end

  it '名言を削除できること' do
    create(:quote, child: my_child, user:)
    visit quotes_path
    expect(page).to have_content 'ママもお勉強がんばってね！'

    click_on '削除'
    expect(page.accept_confirm).to eq('本当に削除しますか？')
    expect(page).to have_content '名言を削除しました'

    expect(page).not_to have_content 'ママもお勉強がんばってね！'
  end
end
