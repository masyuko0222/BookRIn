import React from 'react';

export const TemplateActions = ({ editor, template }) => {
	const ApplyTemplateToContent = () => {
		if (template) {
			const confirmApply = window.confirm('ノートの内容を上書きします。よろしいですか？');
			if (confirmApply) {
				editor.commands.clearContent();
				editor.commands.setContent(template);
			}
		}
	};

	return (
		<ul className='flex space-x-2'>
			<li className='self-end'>
				<button onClick={ApplyTemplateToContent} className='font-semibold text-blue-600 underline'>
					テンプレートを反映する
				</button>
			</li>
			<li className='self-end'>
				<button type='button' className='text-gray-600 underline'>
					テンプレートを変更する
				</button>
			</li>
		</ul>
	);
};
