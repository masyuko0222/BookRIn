# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NoteHelper, type: :helper do
  include ActionView::Helpers::SanitizeHelper
  include Rails.application.routes.url_helpers

  let(:note) { Note.new(held_on: Date.new(2024, 1, 1), title: '新年ノート') }

  describe '.title_with_held_on' do
    it 'returns a string with date and title' do
      expect(title_with_held_on(note)).to eq '1月1日 新年ノート'
    end
  end

  describe '.submit_button_text' do
    let(:new_note) { Note.new }
    let(:reading_club) { FactoryBot.create(:reading_club, :opening_club) }
    let(:existing_note) { FactoryBot.create(:note, reading_club: reading_club) }

    context 'when the note is new' do
      it 'returns "作成"' do
        expect(submit_button_text(new_note)).to eq '作成'
      end
    end

    context 'when the note already exists' do
      it 'returns "ノートを更新"' do
        expect(submit_button_text(existing_note)).to eq 'ノートを更新'
      end
    end
  end

  describe '.summary_with_highlight' do
    it 'returns summary with highlighted search word' do
      note.content = '<h1>こんにちは!</h1><p>こんばんは!</p>'
      search_word = 'こん'
      expected = '<span class="font-bold bg-yellow-200">こん</span>にちは! '\
                 '<span class="font-bold bg-yellow-200">こん</span>ばんは! ...'

      expect(summary_with_highlight(note.content, search_word)).to eq expected
    end
  end
end
