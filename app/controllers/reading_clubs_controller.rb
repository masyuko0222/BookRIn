# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    set_default_params(current_user)

    @q = ReadingClub.ransack(params[:q])
    result = @q.result.includes(:participants, :users)

    sorted_clubs =
      ReadingClub.sort_by_participations(
        result,
        current_user,
        is_requested_open: requseted_open?
      )
    @reading_clubs = paging(sorted_clubs)
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

  def requseted_open?
    params.dig(:q, :finished_eq) != 'true'
  end

  def paging(clubs)
    Kaminari.paginate_array(clubs).page(params[:page])
  end
end
