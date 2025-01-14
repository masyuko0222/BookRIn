import React from 'react';
import PropTypes from 'prop-types';
import { useEditor, EditorContent } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';

const NoteEditor = ({ content }) => {
	const editor = useEditor({
		extensions: [StarterKit],
		content: content,
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
