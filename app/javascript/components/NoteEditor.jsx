import React from 'react';
import PropTypes from 'prop-types';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

const NoteEditor = ({ content }) => {
	const editor = useEditor({
		extensions: [StarterKit],
		content: content,
		editorProps: {
			attributes: {
				class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
				style: 'height: 24rem; overflow: auto;',
			},
		},
	});

	editor.on('update', ({ editor }) => {
		const updatedContent = editor.getHTML();
		document.getElementById('note-editor-hidden').value = updatedContent;
	});

	return <EditorContent editor={editor} />;
};

NoteEditor.propTypes = {
	content: PropTypes.string.isRequired,
};

export default NoteEditor;
