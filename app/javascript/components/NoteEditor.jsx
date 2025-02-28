import React, { useEffect } from 'react';

import { WebsocketProvider } from 'y-websocket';
import { EditorContent } from '@tiptap/react';

export const NoteEditor = ({ yDoc, editor, isNew, noteId, content }) => {
  useEffect(() => {
    if (isNew) return;

    const wsProvider = new WebsocketProvider('ws://localhost:5678', noteId, yDoc);
    wsProvider.on('sync', (isSynced) => {
      if (isSynced) {
        if (!yDoc.getMap('config').get('initialContentLoaded') && editor) {
          yDoc.getMap('config').set('initialContentLoaded', true);
          editor.commands.setContent(content);
          document.getElementById('note-editor-hidden').value = content;
        }
      }
    });

    return () => {
      wsProvider?.destroy();
      yDoc?.destroy();
    };
  }, []);

  return <EditorContent editor={editor} />;
};
