# frozen_string_literal: true

class ReadingClubs::ParticipantsController < ApplicationController
  before_action :set_participant, only: :destroy

  def create
    participant = current_user.participants.new(participant_params)

    if participant.save
      redirect_to reading_clubs_path # TODO: success message
    else
      render 'reading_clubs/index' # TODO: failure message
    end
  end

  def destroy
    @participant.destroy
    redirect_to reading_clubs_path # TODO: success message
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.permit(:reading_club_id)
  end
end
