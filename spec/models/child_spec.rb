# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Child', type: :model do
  it 'ファクトリが有効であること' do
    child = build(:child)
    expect(child).to be_valid
  end
end
