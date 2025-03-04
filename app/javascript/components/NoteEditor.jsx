import React, { useEffect, useRef } from 'react';
import { EditorContent } from '@tiptap/react';
import { useEditor } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';
import { WebsocketProvider } from 'y-websocket';
import * as Y from 'yjs';

const yDoc = new Y.Doc();

export const NoteEditor = ({ setEditor, isNew, noteId, content, currentTemplate, changeContent }) => {
  const wsProvider = useRef(null);

  useEffect(() => {
    setEditor(editor);
    if (isNew) return;
    wsProvider.current = new WebsocketProvider('ws://localhost:5678', noteId, yDoc);
    wsProvider.current?.connect();

    wsProvider.current?.on('sync', (isSynced) => {
      if (isSynced) {
        if (!yDoc.getMap('config').get('initialContentLoaded') && editor) {
          yDoc.getMap('config').set('initialContentLoaded', true);
          editor.commands.setContent(content);
          document.getElementById('note-editor-hidden').value = content;
        }
      }
    });

    return () => {
      wsProvider.current?.destroy();
      yDoc?.destroy();
    };
  }, []);

  const editor = useEditor({
    extensions: [StarterKit, ...(isNew ? [] : [Collaboration.configure({ document: yDoc })])],
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

  return <EditorContent editor={editor} />;
};
