# frozen_string_literal: true

module QuotesHelper
  def year_of_birth(date_of_birth)
    passed_month = (Time.zone.now - date_of_birth.to_time).to_i / 1.month
    (passed_month / 12).to_s
  end

  def month_of_birth(date_of_birth)
    passed_month = (Time.zone.now - date_of_birth.to_time).to_i / 1.month
    (passed_month % 12).to_s
  end
end
