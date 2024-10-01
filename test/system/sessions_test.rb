# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(
      provider: 'discord',
      uid: '12345678',
      info: {
        name: 'TestMan'
      }
    )
  end

  teardown do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:discord] = nil
  end

  test 'login' do
    visit login_path
    click_on 'Login with Discord'
    assert_current_path root_path
    # TODO
    # assert_text "Success Login"
  end

  test 'login failure' do
    OmniAuth.config.mock_auth[:discord] = :invalid_credentials
    visit login_path
    click_on 'Login with Discord'
    assert_current_path login_path
    # TODO
    # assert_text "Failure Login"
  end
end
