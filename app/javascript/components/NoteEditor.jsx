import PropTypes from 'prop-types';
import React, { useEffect } from 'react';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

import Collaboration from '@tiptap/extension-collaboration';
import { WebsocketProvider } from 'y-websocket';
import * as Y from 'yjs';

const NoteEditor = ({ isNew, id, content }) => {
	const yDoc = new Y.Doc();

	const editor = useEditor({
		extensions: [StarterKit, ...(isNew ? [] : [Collaboration.configure({ document: yDoc })])],
		editorProps: {
			attributes: {
				class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
				style: 'height: 70vh; overflow: auto;',
			},
		},
	});

	editor?.on('update', ({ editor }) => {
		const updatedContent = editor.getHTML();
		document.getElementById('note-editor-hidden').value = updatedContent;
	});

	useEffect(() => {
		if (isNew) return;

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
			yDoc?.destroy();
		};
	}, []);

	return <EditorContent editor={editor} />;
};

NoteEditor.propTypes = {
	isNew: PropTypes.bool,
	id: PropTypes.string,
	content: PropTypes.string,
};

export default NoteEditor;
