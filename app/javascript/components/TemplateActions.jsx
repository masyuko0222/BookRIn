import React, { useState } from 'react';

export const TemplateActions = ({ originalTemplate, onApplyTemplate, onUpdateTemplate }) => {
  const [showEditTemplate, setShowEditTemplate] = useState(false);
  const [latestTemplate, setLatestTemplate] = useState(originalTemplate);

  return (
    <>
      <ul className='flex mb-2 space-x-2'>
        <li className='self-end'>
          <button
            type='button'
            onClick={() => onApplyTemplate(latestTemplate)}
            className='text-caution font-semibold underline'
          >
            テンプレートをノートに反映する
          </button>
        </li>
        <li className='self-end'>
          <button type='button' onClick={() => setShowEditTemplate(true)} className='text-gray-600 underline'>
            テンプレートを編集する
          </button>
        </li>
      </ul>

      {showEditTemplate && (
        <>
          <div className='mb-2 h-full p-2 border border-gray-300 bg-gray-100 rounded-lg'>
            <h2 className='text-lg font-semibold'>テンプレート編集</h2>

            <textarea
              className='mt-2 template-content-area w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 h-[200px]'
              value={latestTemplate}
              onChange={(e) => setLatestTemplate(e.target.value)}
            />

            <div className='mt-2 flex space-x-2'>
              <button
                className='inline-flex items-center px-4 py-2 bg-blue-600 text-white border border-blue-600 rounded-lg cursor-pointer hover:bg-blue-700'
                type='button'
                onClick={() => {
                  onUpdateTemplate(latestTemplate);
                  setShowEditTemplate(false);
                }}
              >
                更新
              </button>
              <button
                className='inline-flex items-center px-4 py-2 bg-gray-100 text-gray-600 border border-gray-300 rounded-lg hover:bg-gray-200'
                type='button'
                onClick={() => {
                  setLatestTemplate(originalTemplate);
                  setShowEditTemplate(false);
                }}
              >
                キャンセル
              </button>
            </div>
          </div>
        </>
      )}
    </>
  );
};
