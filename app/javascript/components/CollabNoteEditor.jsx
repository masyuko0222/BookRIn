import React, { useEffect } from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';
import CollaborationCursor from '@tiptap/extension-collaboration-cursor';

export const CollabNoteEditor = ({ wsProvider, yDoc, setEditor, content, userName }) => {
  useEffect(() => {
    wsProvider.on('synced', () => {
      if (!yDoc.getMap('config').get('initialContentLoaded')) {
        yDoc.getMap('config').set('initialContentLoaded', true);
        editor.commands.setContent(content);
        document.getElementById('note-editor-hidden').value = content;
      }
    });
  });

  const colors = [
    '#958DF1',
    '#F98181',
    '#FBBC88',
    '#FAF594',
    '#70CFF8',
    '#94FADB',
    '#B9F18D',
    '#C3E2C2',
    '#EAECCC',
    '#AFC8AD',
    '#EEC759',
    '#9BB8CD',
    '#FF90BC',
    '#FFC0D9',
    '#DC8686',
    '#7ED7C1',
    '#F3EEEA',
    '#89B9AD',
    '#D0BFFF',
    '#FFF8C9',
    '#CBFFA9',
    '#9BABB8',
    '#E3F4F4',
  ];

  const getRandomElement = (list) => list[Math.floor(Math.random() * list.length)];
  const getRandomColor = () => getRandomElement(colors);

  const editor = useEditor({
    extensions: [
      StarterKit,
      Collaboration.configure({ document: yDoc }),
      CollaborationCursor.configure({
        provider: wsProvider,
        user: {
          name: userName,
          color: getRandomColor(),
        },
      }),
    ],
    editorProps: {
      attributes: {
        class: 'border border-gray-300 p-4 rounded focus:ring-blue-500 h-[70vh] overflow-auto',
      },
    },
    onCreate({ editor }) {
      setEditor(editor);
    },
    onUpdate({ editor }) {
      document.getElementById('note-editor-hidden').value = editor.getHTML();
    },
  });

  return <EditorContent editor={editor} />;
};
