# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    set_default_params
    @q = ReadingClub.ransack(params[:q])

    @reading_clubs = Kaminari.paginate_array(sort_reading_clubs(params[:q])).page(params[:page])
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

  def sort_reading_clubs(search_query)
    result = @q.result.order(updated_at: :desc)

    if search_query[:finished_eq] == 'true' || search_query[:title_cont].present?
      result
    else
      open_and_participating_clubs =
        current_user.participating_reading_clubs.open.order('participants.created_at DESC')

      (open_and_participating_clubs + result)
        .uniq(&:id)
    end
  end
end
