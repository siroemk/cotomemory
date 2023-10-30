# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuotesHelper, type: :helper do
  include ActiveSupport::Testing::TimeHelpers

  describe '#convert_to_age' do
    let(:child) { create(:child, date_of_birth: '2020/06/20'.to_date) }

    context '誕生日（2020/06/20）より前の場合' do
      it '2023/4/20だと（2才10ヶ月）が返る' do
        travel_to Time.zone.local(2023, 4, 20) do
          expect(convert_to_age(child.date_of_birth)).to eq('（2才10ヶ月）')
        end
      end

      it '2023/6/19だと（2才11ヶ月）が返る' do
        travel_to Time.zone.local(2023, 6, 19) do
          expect(convert_to_age(child.date_of_birth)).to eq('（2才11ヶ月）')
        end
      end
    end

    context '誕生日当日の場合' do
      it '2023/6/20だと（3才0ヶ月）が返る' do
        travel_to Time.zone.local(2023, 6, 20) do
          expect(convert_to_age(child.date_of_birth)).to eq('（3才0ヶ月）')
        end
      end
    end

    context '誕生日（2020/06/20）より後の場合' do
      it '2023/6/21だと（3才0ヶ月）が返る' do
        travel_to Time.zone.local(2023, 6, 21) do
          expect(convert_to_age(child.date_of_birth)).to eq('（3才0ヶ月）')
        end
      end

      it '2023/8/20だと（3才2ヶ月）が返る' do
        travel_to Time.zone.local(2023, 8, 20) do
          expect(convert_to_age(child.date_of_birth)).to eq('（3才2ヶ月）')
        end
      end
    end
  end
end
