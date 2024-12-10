# frozen_string_literal: true

class ReadingClubsController < ApplicationController

  def index
    initialize_default_params

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

  private

  def initialize_default_params
    params[:q] ||= {}
    params[:q][:finished_eq] ||= 'false'
  end

  def requseted_only_participating?
    params.dig(:q, :users_uid_cont) == current_user.uid.to_s
  end
end
