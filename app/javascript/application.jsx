// Entry point for the build script in your package.json
import './controllers';
import '@hotwired/turbo-rails';

import React, { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { EditorContainer } from './components/EditorContainer';

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('note-editor-container');
  if (container) {
    // NODE_ENVがdevelopmentになってしまうので、解決できるまではRails.envで環境判断をする
    // https://community.fly.io/t/node-env-is-always-development-regardless-of-my-secrets-and-configuration/4825
    const { isNew, railsEnv, userName, clubId, noteId, content, template } = container.dataset;

    const root = createRoot(container);
    root.render(
      <StrictMode>
        <EditorContainer
          isNew={isNew === 'true'}
          railsEnv={railsEnv}
          userName={userName}
          clubId={clubId}
          noteId={noteId}
          content={content}
          template={template}
        />
      </StrictMode>
    );
  }
});
