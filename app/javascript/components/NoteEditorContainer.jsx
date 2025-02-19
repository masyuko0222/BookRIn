import React, { useState } from 'react';
import { TemplateActions } from './TemplateActions';
import { NoteEditor } from './NoteEditor';
import { FlashMessage } from './FlashMessage';

import { useEditor } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';
import * as Y from 'yjs';
import { marked } from 'marked';

export const NoteEditorContainer = ({ isNew, clubId, noteId, content, template }) => {
  const [currentTemplate, setCurrentTemplate] = useState(template);
  const [flashMessage, setFlashMessage] = useState(null);
  const yDoc = new Y.Doc();

  const changeContent = (tiptapEditor, text) => {
    tiptapEditor.commands.clearContent();
    tiptapEditor.commands.setContent(marked.parse(text));

    // submitはRailsのform_helperで行われるので、RailsViewのhidden_fieldにも値を渡す
    document.getElementById('note-editor-hidden').value = marked.parse(text);
  };

  const editor = useEditor({
    extensions: [
      StarterKit,
      // IDがないとWebsocket通信(共同編集)ができないので、新規作成画面ではコラボ機能はなし
      ...(isNew ? [] : [Collaboration.configure({ document: yDoc })]),
    ],
    editorProps: {
      attributes: {
        class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
        style: 'height: 70vh; overflow: auto;',
      },
    },
    onCreate({ editor }) {
      isNew && changeContent(editor, currentTemplate);
    },
    onUpdate({ editor }) {
      document.getElementById('note-editor-hidden').value = editor.getHTML();
    },
  });

  // TemplateAction's handlers
  const handleApplyTemplate = (latestTemplate) => {
    if (latestTemplate && window.confirm('ノートの内容を上書きします。よろしいですか？')) {
      changeContent(editor, latestTemplate);
    }
  };

  const handleUpdateTemplate = async (latestTemplate) => {
    setCurrentTemplate(latestTemplate);

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

      const response = await fetch(`/reading_clubs/${clubId}/template`, {
        method: 'PATCH',
        body: JSON.stringify({ template: latestTemplate, note_id: noteId, reading_club_id: clubId }),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken,
          Accept: 'application/json',
        },
      });

      const data = await response.json();
      setFlashMessage(data.flash);
    } catch {
      setFlashMessage('ネットワークエラー');
    }
  };

  // Flash's handler
  const handleCloseFlash = () => setFlashMessage(null);

  return (
    <>
      {flashMessage && <FlashMessage message={flashMessage} onCloseFlash={handleCloseFlash} />}
      <TemplateActions
        editor={editor}
        originalTemplate={currentTemplate}
        onApplyTemplate={handleApplyTemplate}
        onUpdateTemplate={handleUpdateTemplate}
      />
      <NoteEditor yDoc={yDoc} editor={editor} isNew={isNew} noteId={noteId} content={content} />
    </>
  );
};
