// Entry point for the build script in your package.json
import './controllers';
import '@hotwired/turbo-rails';

import React, { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { NoteEditorContainer } from './components/NoteEditorContainer';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('note-editor-container');
  if (container) {
    const { isNew, clubId, noteId, content, template } = container.dataset;

    const root = createRoot(container);
    root.render(
      <StrictMode>
        <NoteEditorContainer
          isNew={isNew === 'true'}
          clubId={clubId}
          noteId={noteId}
          content={content}
          template={template}
        />
      </StrictMode>
    );
  }
});
