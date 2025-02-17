import React, { useState } from 'react';

export const TemplateActions = ({ originalTemplate, onApplyTemplate, onUpdateTemplate }) => {
	const [showModal, setShowModal] = useState(false);
	const [latestTemplate, setLatestTemplate] = useState(originalTemplate);

	return (
		<>
			<ul className='flex space-x-2'>
				<li className='self-end'>
					<button
						type='button'
						onClick={() => {
							onApplyTemplate(latestTemplate);
						}}
						className='font-semibold text-blue-600 underline'
					>
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
				<>
					<textarea
						className='template-modal'
						value={latestTemplate}
						onChange={(e) => {
							setLatestTemplate(e.target.value);
						}}
						rows='10'
						cols='50'
					/>
					<button
						type='button'
						onClick={() => {
							onUpdateTemplate(latestTemplate);
							setShowModal(false);
						}}
					>
						更新
					</button>
					<button
						type='button'
						onClick={() => {
							setLatestTemplate(originalTemplate);
							setShowModal(false);
						}}
					>
						キャンセル
					</button>
				</>
			)}
		</>
	);
};
