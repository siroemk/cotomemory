# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      name: user.name
    )
    visit root_path
    click_on 'Googleでログイン', match: :first
  end
end
