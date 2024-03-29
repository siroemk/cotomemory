# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    it 'ログインに成功する' do
      user = create(:user)
      auth_hash = { provider: user.provider, uid: user.uid, info: { name: user.name } }
      expect(User.from_omniauth(auth_hash)).to eq user
    end

    it 'auth_hashに無効な値が入っていた場合ログインに失敗する' do
      user = build(:user)
      auth_hash = { provider: 'google', uid: nil, info: { name: user.name } }
      expect(User.from_omniauth(auth_hash)).not_to eq user
    end
  end

  describe '#create_or_belong_family(invitation_token)' do
    it 'invitation_tokenに値が入っていた場合、同じinvitation_tokenを持つfamilyと紐付ける' do
      user = create(:user)
      invited_user = build(:user, family: nil)

      invitation_token = user.family.invitation_token
      invited_user.create_or_belong_family(invitation_token)
      expect(invited_user.family).to eq user.family
    end

    it 'invitation_tokenに値が入っていなかった場合、新しくfamilyを作成する' do
      new_user = build(:user, family: nil)
      expect(new_user).to_not be_valid

      new_user.create_or_belong_family(nil)
      expect(new_user).to be_valid
    end

    it '無効なinvitation_tokenの場合エラーになる' do
      invited_user = build(:user, family: nil)
      expect { invited_user.create_or_belong_family('test123456789') }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe '#validate_avatar' do
    context 'プロフィール画像が添付された場合' do
      let(:large_image) { fixture_file_upload(Rails.root.join('spec/fixtures/large_image.jpg'), 'image/jpeg') }
      let(:invalid_file) { fixture_file_upload(Rails.root.join('spec/fixtures/invalid_file.txt'), 'text/plain') }

      it '画像サイズが1MBより大きければエラーが表示される' do
        user = create(:user)
        user.avatar.attach(large_image)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('プロフィール画像のファイルサイズは1MB以下にしてください')
      end

      it '画像がjpeg,jpg,png以外であればエラーが表示される' do
        user = create(:user)
        user.avatar.attach(invalid_file)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('プロフィール画像はjpeg,jpg,pngのいずれかにしてください')
      end
    end
  end

  describe '#belong_to_same_family?' do
    let(:user) { create(:user) }

    it '同じ家族の場合、trueが返る' do
      my_child = create(:child, family: user.family)
      expect(user.belong_to_same_family?(my_child)).to be true
    end

    it '異なる家族の場合、falseが返る' do
      other_child = create(:child)
      expect(user.belong_to_same_family?(other_child)).to be false
    end
  end
end
