# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Children', type: :system do
  let(:user) { create(:user) }
  let(:child) { create(:child, family: user.family) }

  before do
    sign_in_as(user)
  end

  describe '#index' do
    context 'こどもが登録されていない場合' do
      it '「こどもの情報が登録されていません。」と表示される' do
        visit children_path
        expect(page).to have_content 'こどもの情報が登録されていません。'
      end
    end

    context 'こどもが登録されている場合' do
      it 'こどもの情報が表示される' do
        create(:child, family: user.family, name: 'かな', date_of_birth: '2023/01/01')
        visit children_path
        expect(page).to have_content 'かな'
        expect(page).to have_content '2023/01/01'
      end
    end
  end

  describe '#create' do
    it 'こどもを登録できること' do
      visit new_child_path
      fill_in 'child[name]', with: '花子'
      select '2023', from: 'child_date_of_birth_1i'
      select '2', from: 'child_date_of_birth_2i'
      select '14', from: 'child_date_of_birth_3i'
      click_on '保存する'
      expect(page).to have_content 'こどもの情報を登録しました'

      visit children_path
      expect(page).to have_content '花子'
      expect(page).to have_content '2023/02/14'
    end

    context 'こどもの登録フォームで名前が空白の場合' do
      it '「こどもの名前を入力してください」と表示されること' do
        fill_in 'child[name]', with: ''
        select '2023', from: 'child_date_of_birth_1i'
        select '1', from: 'child_date_of_birth_2i'
        select '1', from: 'child_date_of_birth_3i'
        click_on '保存する'
        expect(page).to have_content 'こどもの名前を入力してください'
      end
    end
  end

  describe '#edit' do
    it 'こどもを編集できること' do
      visit edit_child_path(child)
      fill_in 'child[name]', with: '太郎'
      select '2016', from: 'child_date_of_birth_1i'
      select '8', from: 'child_date_of_birth_2i'
      select '1', from: 'child_date_of_birth_3i'
      click_on '保存する'
      expect(page).to have_content 'こどもの情報を編集しました'

      visit children_path
      expect(page).to have_content '太郎'
      expect(page).to have_content '2016/08/01'
    end

    context 'こどもの編集フォームで名前が空白の場合' do
      it '「こどもの名前を入力してください」と表示されること' do
        visit edit_child_path(child)
        fill_in 'child[name]', with: ''
        select '2022', from: 'child_date_of_birth_1i'
        select '1', from: 'child_date_of_birth_2i'
        select '1', from: 'child_date_of_birth_3i'
        click_on '保存する'
        expect(page).to have_content 'こどもの名前を入力してください'
      end
    end

    context '別の家族のこどもの編集フォームにアクセスした場合' do
      it '「ご指定のページはアクセスできませんでした」と表示されること' do
        other_child = create(:child)
        visit edit_child_path(other_child)
        expect(page).to have_content 'ご指定のページはアクセスできませんでした'
      end
    end
  end

  describe '#destroy' do
    it 'こどもを削除できること' do
      visit edit_child_path(child)
      click_on 'こどもの情報を削除する'
      expect(page.accept_confirm).to eq('こどもの情報を削除すると名言も削除されます。本当に削除しますか？')
      expect(page).to have_content 'こどもの情報を削除しました'
      expect(page).to have_content 'こどもの情報が登録されていません'
    end
  end
end
