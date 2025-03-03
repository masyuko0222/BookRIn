import React, { useEffect } from 'react';
import { EditorContent } from '@tiptap/react';

export const NoteEditor = ({ yDoc, wsProvider, editor, isNew, content }) => {
  useEffect(() => {
    if (isNew) return;
    wsProvider.connect();

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
