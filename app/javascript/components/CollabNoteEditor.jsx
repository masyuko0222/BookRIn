import React, { useEffect } from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';

export const CollabNoteEditor = ({ wsProvider, yDoc, setEditor, content }) => {
  useEffect(() => {
    wsProvider.on('synced', () => {
      if (!yDoc.getMap('config').get('initialContentLoaded')) {
        yDoc.getMap('config').set('initialContentLoaded', true);
        editor.commands.setContent(content);
        document.getElementById('note-editor-hidden').value = content;
      }
    });
  });

  const editor = useEditor({
    extensions: [StarterKit, Collaboration.configure({ document: yDoc })],
    editorProps: {
      attributes: {
        class: 'border border-gray-300 p-4 rounded focus:ring-blue-500',
        style: 'height: 70vh; overflow: auto;',
      },
    },
    onCreate({ editor }) {
      setEditor(editor);
    },
  });

  return <EditorContent editor={editor} />;
};
