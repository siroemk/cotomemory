# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Families', type: :system do
  let(:mother) { create(:user) }

  before do
    sign_in_as(mother)
  end

  describe '#show' do
    it '招待URLが表示される' do
      visit family_path
      expect(page).to have_content "welcome?invitation_token=#{mother.family.invitation_token}"
    end

    context '家族が登録している場合' do
      it '家族の一覧に家族の名前が表示される' do
        create(:user, family: mother.family, name: 'パパ')
        visit family_path
        expect(page).to have_content 'パパ'
      end
    end

    context '家族が登録していない場合' do
      it '家族の一覧に「こどもの情報を共有している家族はいません」と表示される' do
        visit family_path
        expect(page).to have_content 'こどもの情報を共有している家族はいません'
      end
    end
  end
end
