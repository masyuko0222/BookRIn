# frozen_string_literal: true

class ReadingClubs::ParticipantsController < ApplicationController
  # 一目で参加/参加取消できたかわかるので、フラッシュは表示させない
  before_action :set_participant, only: :destroy

  def create
    participant = current_user.participants.new(participant_params)

    if participant.save
      redirect_back_or_to reading_clubs_path
    else
      render 'reading_clubs/index', status: :unprocessable_entity
    end
  end

  def destroy
    @participant.destroy
    redirect_back_or_to reading_clubs_path
  end

  private

  def set_participant
    @participant = current_user.participants.find(params[:id])
  end

  def participant_params
    params.permit(:reading_club_id)
  end
end
