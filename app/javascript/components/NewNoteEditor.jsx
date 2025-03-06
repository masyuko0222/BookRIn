import React from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

export const NewNoteEditor = ({ setEditor, currentTemplate, changeContent }) => {
  const editor = useEditor({
    extensions: [StarterKit],
    editorProps: {
      attributes: {
        class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
        style: 'height: 70vh; overflow: auto;',
      },
    },
    onCreate({ editor }) {
      setEditor(editor);
      changeContent(editor, currentTemplate);
    },
    onUpdate({ editor }) {
      document.getElementById('note-editor-hidden').value = editor.getHTML();
    },
  });

  return <EditorContent editor={editor} />;
};
