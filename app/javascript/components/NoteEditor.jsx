import React, { useState } from 'react';
import PropTypes from 'prop-types';

const NoteEditor = ({ content }) => {
	const [initialContent, setInitialContent] = useState(content);

	const handleChange = (e) => {
		setInitialContent(e.target.value);
		document.getElementById('note-editor-hidden').value = e.target.value;
	};

	return <textarea value={initialContent} onChange={handleChange} />;
};

NoteEditor.propTypes = {
	content: PropTypes.string.isRequired,
};

export default NoteEditor;
