# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    set_default_params

    @q = ReadingClub.ransack(params[:q])
    hit_clubs = @q.result.includes(:participants).order(created_at: :desc)

    reading_clubs = if params[:q][:finished_eq] == 'true'
                      hit_clubs
                    else
                      ReadingClub.sort_participating_first(hit_clubs, current_user)
                    end

    @reading_clubs = Kaminari.paginate_array(reading_clubs).page(params[:page])
  end

  def overview
    reading_club = ReadingClub.find(params[:id])

    @read_me = reading_club.read_me
    @notes = reading_club.notes
  end

  private

  def set_default_params
    params[:q] ||= { finished_eq: false }
  end
end
