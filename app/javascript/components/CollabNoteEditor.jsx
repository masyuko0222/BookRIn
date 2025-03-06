import React, { useEffect } from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';

export const CollabNoteEditor = ({ yDoc, setEditor, wsProvider, content }) => {
  const editor = useEditor({
    extensions: [StarterKit, Collaboration.configure({ document: yDoc })],
    editorProps: {
      attributes: {
        class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
        style: 'height: 70vh; overflow: auto;',
      },
    },
    onCreate({ editor }) {
      setEditor(editor);
      if (!yDoc.getMap('config').get('initialContentLoaded')) {
        yDoc.getMap('config').set('initialContentLoaded', true);
        editor.commands.setContent(content);
        document.getElementById('note-editor-hidden').value = content;
      }
    },
  });

  return <EditorContent editor={editor} />;
};
