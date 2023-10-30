# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate_avatar' do
    context 'when avatar is attached' do
      let(:large_image) { fixture_file_upload(Rails.root.join('spec/fixtures/large_image.jpg'), 'image/jpg') }
      let(:invalid_file) { fixture_file_upload(Rails.root.join('spec/fixtures/invalid_file.txt'), 'text/plain') }

      it 'validates file size' do
        user = create(:user)
        user.avatar.attach(large_image)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('プロフィール画像のファイルサイズは1MB以下にしてください')
      end

      it 'validates file format' do
        user = create(:user)
        user.avatar.attach(invalid_file)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('プロフィール画像はjpeg,jpg,pngのいずれかにしてください')
      end
    end
  end
end
