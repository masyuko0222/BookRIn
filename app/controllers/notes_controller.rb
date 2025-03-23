# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[edit update destroy]

  def new
    @note = Note.new(
      reading_club_id: params[:reading_club_id],
      # newページにアクセスしたタイミングで、開催日の値が入っているようにする
      # そのためDBのdefaultではなく、Controllerでheld_onの値を設定しておく
      held_on: Time.zone.today
    )

    render :form
  end

  def edit
    render :form
  end

  def create
    @note = Note.new(note_params.merge(reading_club_id: params[:reading_club_id]))

    if @note.save
      flash.notice = 'ノートを作成しました'
      redirect_to reading_club_overview_path(@note.reading_club_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      flash.now.notice = 'ノートを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    flash.now.notice = 'ノートを削除しました'
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:held_on, :title, :content)
  end
end
