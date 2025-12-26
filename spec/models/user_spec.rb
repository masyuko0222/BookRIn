# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.authenticate_from_omniauth' do
    context 'when the user already exists' do
      let!(:existing_user) { FactoryBot.create(:user, :alice) }
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: existing_user.provider,
          uid: existing_user.uid,
          info: { name: existing_user.name }
        )
      end

      it 'returns the existing user' do
        user = User.authenticate_from_omniauth(auth)
        expect(user).to eq existing_user
      end

      it 'does not create a new user' do
        expect { User.authenticate_from_omniauth(auth) }.to_not change(User, :count)
      end
    end

    context 'when the user does not exist' do
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: 'discord',
          uid: '987654321',
          info: { name: 'New Test Person' }
        )
      end

      it 'creates a new user' do
        expect do
          User.authenticate_from_omniauth(auth)
        end.to change(User, :count).by(1)
      end

      it 'returns the created user' do
        user = User.authenticate_from_omniauth(auth)
        expect(user.provider).to eq 'discord'
        expect(user.uid).to eq '987654321'
        expect(user.name).to eq 'New Test Person'
      end
    end
  end

  describe '#participating?' do
    let(:user) { FactoryBot.create(:user, :alice) }
    let(:reading_club) { FactoryBot.create(:reading_club, :opening_club) }

    it 'returns true if user is participating in club' do
      FactoryBot.create(:participant, user: user, reading_club: reading_club)
      expect(user.participating?(reading_club)).to be true
    end

    it 'returns false if user is not participating in club' do
      expect(user.participating?(reading_club)).to be false
    end
  end
end
