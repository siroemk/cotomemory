# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Family', type: :model do
  it 'ファクトリが有効であること' do
    family = build(:family)
    expect(family).to be_valid
  end
end
