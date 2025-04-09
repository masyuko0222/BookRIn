import React, { useState } from 'react';
import { TemplateActions } from './TemplateActions';
import { NoteEditor } from './NoteEditor';
import { FlashMessage } from './FlashMessage';

import { marked } from 'marked';

export const EditorContainer = ({ isNew, railsEnv, userName, clubId, noteId, content, template }) => {
  const [currentTemplate, setCurrentTemplate] = useState(template);
  const [flashMessage, setFlashMessage] = useState(null);
  const [editor, setEditor] = useState(null);

  const changeContent = (tiptapEditor, text) => {
    tiptapEditor.commands.clearContent();
    tiptapEditor.commands.setContent(marked.parse(text));

    // submitはRailsのform_helperで行われるので、RailsViewのhidden_fieldにも値を渡す
    document.getElementById('note-editor-hidden').value = marked.parse(text);
  };

  // TemplateAction's handlers
  const handleApplyTemplate = (latestTemplate) => {
    if (latestTemplate && window.confirm('ノートの内容を上書きします。よろしいですか？')) {
      changeContent(editor, latestTemplate);
    }
  };

  const handleUpdateTemplate = async (latestTemplate) => {
    setCurrentTemplate(latestTemplate);

    try {
      const headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
      };

      const csrfToken = document.head.querySelector('meta[name=csrf-token]')?.content;
      if (csrfToken) {
        headers['X-CSRF-Token'] = csrfToken;
      }

      const response = await fetch(`/reading_clubs/${clubId}/template`, {
        method: 'PATCH',
        body: JSON.stringify({ template: latestTemplate, reading_club_id: clubId }),
        headers: headers,
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
        originalTemplate={currentTemplate}
        onApplyTemplate={handleApplyTemplate}
        onUpdateTemplate={handleUpdateTemplate}
      />
      <NoteEditor
        setEditor={setEditor}
        isNew={isNew}
        railsEnv={railsEnv}
        userName={userName}
        noteId={noteId}
        content={content}
        currentTemplate={currentTemplate}
        changeContent={changeContent}
      />
    </>
  );
};
