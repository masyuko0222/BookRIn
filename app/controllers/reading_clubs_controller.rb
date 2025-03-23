# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    set_default_params

    @search = ReadingClub.ransack(params[:q])
    result = @search.result.includes(:participants, :users)

    sorted_clubs =
      if requseted_only_participating?
        result.order('participants.created_at DESC, id DESC')
      else
        result.order(updated_at: :desc, id: :desc)
      end

    @reading_clubs = sorted_clubs.page(params[:page]).per(16)
  end

  private

  def set_default_params
    params[:q] ||= {}
    params[:q][:finished_eq] ||= 'false'
    params[:q][:users_uid_cont] ||= current_user.uid
  end

  def requseted_only_participating?
    params.dig(:q, :users_uid_cont) == current_user.uid.to_s
  end
end
