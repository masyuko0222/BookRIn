# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    set_default_params(current_user)

    @q = ReadingClub.ransack(params[:q])
    result = @q.result.includes(:participants, :users)

    sorted_clubs =
      if requseted_only_participating?
        result.order('participants.created_at DESC')
      else
        result.order(updated_at: :desc)
      end

    @reading_clubs = sorted_clubs.page(params[:page])
  end

  def overview
    reading_club = ReadingClub.find(params[:id])

    @read_me = reading_club.read_me
    @notes = reading_club.notes
  end

  private

  def set_default_params(user)
    params[:q] ||= {}
    params[:q][:finished_eq] ||= 'false'
  end

  def requseted_only_participating?
    params.dig(:q, :users_uid_cont) == current_user.uid.to_s
  end
end
