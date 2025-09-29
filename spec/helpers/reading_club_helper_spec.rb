# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingClubHelper, type: :helper do
  describe '#participant_link' do
    let(:user) { FactoryBot.create(:user, :alice) }
    let(:reading_club) { FactoryBot.create(:reading_club, :opening_club) }

    context 'if user does not participate club' do
      it 'returns link to participate' do
        link = participant_link(user, reading_club)

        expect(link).to include('＋ 輪読会に参加する')
        expect(link).to include(reading_club_participants_path(reading_club))
        expect(link).to include('data-turbo-method="post"')
      end
    end

    context 'if user is participating in club' do
      it 'returns link to destroy participation' do
        participant = FactoryBot.create(:participant, user:, reading_club:)
        link = participant_link(user, reading_club)

        expect(link).to include('参加取消')
        expect(link).to include(participant_path(participant))
        expect(link).to include('data-turbo-method="delete"')
      end
    end
  end
end
