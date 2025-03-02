import React, { useState } from 'react';

export const TemplateActions = ({ originalTemplate, onApplyTemplate, onUpdateTemplate }) => {
  const [showEditTemplate, setShowEditTemplate] = useState(false);
  const [latestTemplate, setLatestTemplate] = useState(originalTemplate);

  return (
    <>
      <ul className='flex space-x-2'>
        <li className='self-end'>
          <button
            type='button'
            onClick={() => onApplyTemplate(latestTemplate)}
            className='font-semibold text-blue-600 underline'
          >
            テンプレートを反映する
          </button>
        </li>
        <li className='self-end'>
          <button type='button' onClick={() => setShowEditTemplate(true)} className='text-gray-600 underline'>
            テンプレートを変更する
          </button>
        </li>
      </ul>

      {showEditTemplate && (
        <>
          <div className='mb-2 h-[500px] p-4 border border-gray-300 bg-gray-100 rounded-lg'>
            <h2 className='text-lg font-semibold mb-3'>テンプレートを編集</h2>

            <textarea
              className='template-content-area w-full h-60 p-4 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500'
              value={latestTemplate}
              onChange={(e) => setLatestTemplate(e.target.value)}
            />

            <div className='mt-4 flex space-x-2'>
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
