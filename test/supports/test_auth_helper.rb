# frozen_string_literal: true

module TestAuthHelper
  def visit_with_auth(url, user)
    uri = URI.parse(url)

    login(user)
    visit uri.to_s
  end

  def login(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
      provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name
      }
    )
    visit login_path
    click_on 'Login with Discord'
  end
end
