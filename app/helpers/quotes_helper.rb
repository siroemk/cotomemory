# frozen_string_literal: true

module QuotesHelper
  def convert_to_age(date_of_birth)
    age_year = (Time.zone.today.strftime('%Y%m%d').to_i - date_of_birth.strftime('%Y%m%d').to_i) / 10_000
    age_month = (Time.zone.today.strftime('%m%d').to_i - date_of_birth.strftime('%m%d').to_i) / 100
    age_month = age_month.negative? ? age_month + 12 : age_month

    "（#{age_year}才#{age_month}ヶ月）"
  end
end
