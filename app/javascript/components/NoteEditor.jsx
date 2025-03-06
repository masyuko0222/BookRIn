import React, { useEffect, useState } from 'react';
import { WebsocketProvider } from 'y-websocket';
import { NewNoteEditor } from './NewNoteEditor';
import { CollabNoteEditor } from './CollabNoteEditor';
import * as Y from 'yjs';

const yDoc = new Y.Doc();

export const NoteEditor = ({ setEditor, isNew, noteId, content, currentTemplate, changeContent }) => {
  const [wsProvider, setWsProvider] = useState(null);

  useEffect(() => {
    if (isNew) return;

    const provider = new WebsocketProvider('ws://localhost:5678', noteId, yDoc);
    setWsProvider(provider);

    return () => {
      setWsProvider(null);
    };
  }, []);

  if (isNew) {
    return <NewNoteEditor setEditor={setEditor} currentTemplate={currentTemplate} changeContent={changeContent} />;
  }

  if (!wsProvider) {
    return <h1>Loading...</h1>;
  }

  return <CollabNoteEditor yDoc={yDoc} setEditor={setEditor} wsProvider={wsProvider} content={content} />;
};
