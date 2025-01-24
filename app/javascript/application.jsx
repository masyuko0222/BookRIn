// Entry point for the build script in your package.json
import './controllers';
import '@hotwired/turbo-rails';

import React, { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import NoteEditor from './components/NoteEditor';

document.addEventListener('DOMContentLoaded', () => {
	const noteEditor = document.getElementById('note-editor');
	if (noteEditor) {
		const root = createRoot(noteEditor);
		const id = noteEditor.dataset.id;
		const content = noteEditor.dataset.content;

		root.render(
			<StrictMode>
				<NoteEditor id={id} content={content} />
			</StrictMode>
		);
	}
});
