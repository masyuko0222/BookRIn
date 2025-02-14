# frozen_string_literal: true

class ReadingClubs::TemplateController < ApplicationController
  before_action :set_reading_club, only: :update

  def update
    if @reading_club.update(template: params[:template])
      render json: { flash: 'テンプレートを更新しました', status: 'success' }
    else
      render json: { flash: '更新に失敗しました', status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def set_reading_club
    @reading_club = ReadingClub.find(params[:reading_club_id])
  end
end
