import React, { useEffect } from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

import Collaboration from '@tiptap/extension-collaboration';
import { WebsocketProvider } from 'y-websocket';
import * as Y from 'yjs';

const NoteEditor = ({ id, content }) => {
	const yDoc = new Y.Doc();

	const editor = useEditor({
		extensions: [
			StarterKit,
			Collaboration.configure({
				document: yDoc,
			}),
		],
		editorProps: {
			attributes: {
				class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
				style: 'height: 24rem; overflow: auto;',
			},
		},
	});

	editor?.on('update', ({ editor }) => {
		const updatedContent = editor.getHTML();
		document.getElementById('note-editor-hidden').value = updatedContent;
	});

	useEffect(() => {
		const wsProvider = new WebsocketProvider('ws://localhost:1234', id, yDoc);

		wsProvider.on('sync', (isSynced) => {
			if (isSynced) {
				if (!yDoc.getMap('config').get('initialContentLoaded') && editor) {
					yDoc.getMap('config').set('initialContentLoaded', true);
					editor.commands.setContent(content);
				}
			}
		});

		return () => {
			wsProvider?.destroy();
		};
	}, []);

	return <EditorContent editor={editor} />;
};

export default NoteEditor;
