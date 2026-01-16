# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @exist_user_info = build_discord_auth_hash(uid: '12345678', name: 'Alice')
    @changed_user_info = build_discord_auth_hash(uid: '12345678', name: 'Changed Alice')
    @new_user_info = build_discord_auth_hash(uid: '987654321', name: 'NewTestMan')
  end

  test '#participating?(reading_club)' do
    user = users(:alice)
    reading_club = reading_clubs(:opening_club)
    Participant.create!(user:, reading_club:)

    assert user.participating?(reading_club)

    Participant.find_by(user:, reading_club:).destroy!
    assert_not user.participating?(reading_club)
  end

  test '.get_user_from finds existing user' do
    oauth_user = User.get_user_from(@exist_user_info)
    exist_user = users(:alice)

    assert_equal oauth_user, exist_user
  end

  test '.get_user_from update name if user changed discord name' do
    assert_no_difference 'User.count' do
      oauth_user = User.get_user_from(@changed_user_info)
      exist_user = users(:alice)
      assert_equal 'Changed Alice', exist_user.reload.name
    end
  end

  test '.get_user_from creates new user when not found' do
    assert_difference 'User.count', +1 do
      oauth_user = User.get_user_from(@new_user_info)

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
