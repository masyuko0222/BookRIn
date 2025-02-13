import React, { useState } from 'react';
import { TemplateActions } from './TemplateActions';
import { NoteEditor } from './NoteEditor';
import { FlashMessage } from './FlashMessage';

import { useEditor } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';
import * as Y from 'yjs';

export const NoteEditorContainer = ({ isNew, clubId, noteId, content, template }) => {
	const [currentTemplate, setCurrentTemplate] = useState(template);
	const [flashMessage, setFlashMessage] = useState(null);

	const handleTemplateUpdate = async (updatedTemplate) => {
		const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

		setCurrentTemplate(updatedTemplate);
		try {
			const response = await fetch(`/reading_clubs/${clubId}/template`, {
				method: 'PATCH',
				body: JSON.stringify({ template: updatedTemplate, note_id: noteId, reading_club_id: clubId }),
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': csrfToken,
					Accept: 'application/json',
				},
			});

			const data = await response.json();
			setFlashMessage(data.flash);
		} catch {
			setFlashMessage('ネットワークエラー');
		}
	};

	const handleCloseFlash = () => setFlashMessage(null);

	const yDoc = new Y.Doc();

	// Railsでform submitをするため、RailsViewのhidden_fieldにcontentを送る
	const setContentToHiddenField = (content) => {
		document.getElementById('note-editor-hidden').value = content;
	};

	const editor = useEditor({
		extensions: [StarterKit, ...(isNew ? [] : [Collaboration.configure({ document: yDoc })])],
		editorProps: {
			attributes: {
				class: 'mr-2 border border-gray-300 p-4 rounded focus:ring-blue-500',
				style: 'height: 70vh; overflow: auto;',
			},
		},
		onCreate({ editor }) {
			if (isNew) {
				editor.commands.setContent(template);
				setContentToHiddenField(template);
			}
		},
		onUpdate({ editor }) {
			const updatedContent = editor.getHTML();
			setContentToHiddenField(updatedContent);
		},
	});

	return (
		<>
			{flashMessage && <FlashMessage message={flashMessage} onCloseFlash={handleCloseFlash} />}
			<TemplateActions editor={editor} template={currentTemplate} onTemplateUpdate={handleTemplateUpdate} />
			<NoteEditor yDoc={yDoc} editor={editor} isNew={isNew} noteId={noteId} content={content} />
		</>
	);
};
