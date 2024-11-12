# frozen_string_literal: true

class ReadingClubs::ParticipantsController < ApplicationController
  before_action :set_participant, only: :destroy

  def create
    participant = current_user.participants.new(participant_params)

    if participant.save
      flash[:notice] = '輪読会に参加しました！'
      redirect_to reading_clubs_path
    else
      flash[:alert] = '輪読会の参加に失敗しました 時間を空けて再度お試しください'
      render 'reading_clubs/index'
    end
  end

  def destroy
    @participant.destroy
    flash[:alert] = '輪読会の参加を取り消しました'
    redirect_to reading_clubs_path
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.permit(:reading_club_id)
  end
end
