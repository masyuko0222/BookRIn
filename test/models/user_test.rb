# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @exist_user_info = build_discord_auth_hash(uid: '12345678', name: 'TestMan')
    @new_user_info = build_discord_auth_hash(uid: '987654321', name: 'NewTestMan')
  end

  test '#participating?(reading_club)' do
    user = users(:user1)
    reading_club = reading_clubs(:opening_club)
    Participant.create!(user:, reading_club:)

    assert user.participating?(reading_club)
  end

  test '.find_or_create_from_discord_info finds existing user' do
    oauth_user = User.find_or_create_from_discord_info(@exist_user_info)
    exist_user = users(:user1)

    assert_equal oauth_user, exist_user
  end

  test '.find_or_create_from_discord_info creates new user when not found' do
    assert_difference 'User.count', +1 do
      oauth_user = User.find_or_create_from_discord_info(@new_user_info)

      assert_equal 'discord', oauth_user.provider
      assert_equal '987654321', oauth_user.uid
      assert_equal 'NewTestMan', oauth_user.name
    end
  end

  private

  # テストが多くなったらsupportsに移動すること
  def build_discord_auth_hash(uid:, name:)
    OmniAuth::AuthHash.new(
      provider: 'discord',
      uid:,
      info: { name: }
    )
  end
end
