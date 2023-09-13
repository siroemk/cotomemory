# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  it 'ファクトリが有効であること' do
    comment = build(:comment)
    expect(comment).to be_valid
  end
end
