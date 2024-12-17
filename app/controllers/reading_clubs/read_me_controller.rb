# frozen_string_literal: true

class ReadingClubs::ReadMeController < ApplicationController
  before_action :set_reading_club, only: %i[edit update]

  def edit; end

  def update
    if @reading_club.update(read_me_params)
      flash.now.notice = 'READ MEを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_reading_club
    @reading_club = ReadingClub.find(params[:reading_club_id])
  end

  def read_me_params
    params.require(:reading_club).permit(:read_me)
  end
end
