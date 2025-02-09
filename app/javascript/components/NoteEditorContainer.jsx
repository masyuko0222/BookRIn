import React from 'react';
import { TemplateActions } from './TemplateActions';
import { NoteEditor } from './NoteEditor';

import { useEditor } from '@tiptap/react';
import StarterKit from '@tiptap/starter-kit';
import Collaboration from '@tiptap/extension-collaboration';
import * as Y from 'yjs';

export const NoteEditorContainer = ({ isNew, id, content, template }) => {
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
			<TemplateActions editor={editor} template={template} />
			<NoteEditor yDoc={yDoc} editor={editor} isNew={isNew} id={id} content={content} template={template} />
		</>
	);
};
