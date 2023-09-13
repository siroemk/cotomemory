# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quote', type: :model do
  it 'ファクトリが有効であること' do
    quote = build(:quote)
    expect(quote).to be_valid
  end
end
