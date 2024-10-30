# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    # 初期表示、または参加(取消)ボタンを押した時は、開催中かつ１ページ目を表示するようにする
    params[:q] ||= { finished_eq: false }

    @q = ReadingClub.ransack(params[:q])

    @reading_clubs = Kaminari.paginate_array(sort_reading_clubs(params[:q])).page(params[:page])
  end

  def overview
    reading_club = ReadingClub.find(params[:id])

    @read_me = reading_club.read_me
    @notes = reading_club.notes
  end

  private

  def sort_reading_clubs(search_query)
    result = @q.result.order(updated_at: :desc)

    if search_query[:finished_eq] == 'true' || search_query[:title_cont].present?
      result
    else
      (ReadingClub.opening_clubs_participated_by(current_user) + result)
        .uniq(&:id)
    end
  end
end
