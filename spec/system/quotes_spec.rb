# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quotes', type: :system do
  let(:user) { create(:user) }

  it '名言を登録できること' do
    sign_in_as(user)
    fill_in 'child[name]', with: '花子'
    click_on '保存する'

    click_link nil, href: new_quote_path
    fill_in 'quote[content]', with: 'テストの名言です'
    click_on '登録する'
    expect(current_path).to eq quotes_path
    expect(page).to have_content 'テストの名言です'
  end
end
