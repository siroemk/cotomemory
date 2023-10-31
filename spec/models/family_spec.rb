# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Family, type: :model do
  describe '#destoy_when_all_families_left!' do
    it '全ての家族が退会したらFamilyを削除する' do
      mother = create(:user)
      mother.destroy!
      expect { mother.family.destoy_when_all_families_left! }.to change(Family, :count).by(-1)
    end

    it 'Familyに紐づく家族がいればFamilyを残す' do
      mother = create(:user)
      create(:user, name: 'パパ', family: mother.family)
      mother.destroy!
      expect { mother.family.destoy_when_all_families_left! }.to change(Family, :count).by(0)
    end
  end
end
