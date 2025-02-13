import React, { useState } from 'react';

export const TemplateActions = ({ editor, template, onTemplateUpdate }) => {
	const ApplyTemplateToContent = () => {
		if (template) {
			const confirmApply = window.confirm('ノートの内容を上書きします。よろしいですか？');
			if (confirmApply) {
				editor.commands.clearContent();
				editor.commands.setContent(template);
			}
		}
	};

	const [showModal, setShowModal] = useState(false);
	const [updatedTemplate, setUpdatedTemplate] = useState(template);

	const handleTemplateUpdate = () => {
		onTemplateUpdate(updatedTemplate);
		setShowModal(false);
	};

	const handleTemplateChange = (event) => {
		setUpdatedTemplate(event.target.value);
	};

	return (
		<>
			<ul className='flex space-x-2'>
				<li className='self-end'>
					<button type='button' onClick={ApplyTemplateToContent} className='font-semibold text-blue-600 underline'>
						テンプレートを反映する
					</button>
				</li>
				<li className='self-end'>
					<button
						type='button'
						onClick={() => {
							setShowModal(true);
						}}
						className='text-gray-600 underline'
					>
						テンプレートを変更する
					</button>
				</li>
			</ul>

			{showModal && (
				<div className='modal'>
					<textarea value={updatedTemplate} onChange={handleTemplateChange} rows='10' cols='50' />
					<button type='button' onClick={handleTemplateUpdate}>更新</button>
					<button type='button' onClick={() => setShowModal(false)}>キャンセル</button>
				</div>
			)}
		</>
	);
};
