import React from 'react';

export const FlashMessage = ({ message, onCloseFlash }) => (
	<div className='fixed top-4 right-4 z-50 flex items-center px-4 py-3 rounded-lg text-white bg-green-500 bg-opacity-80'>
		<p className='font-semibold mr-2'>{message}</p>
		<button type='button' onClick={onCloseFlash} className='text-lg font-bold cursor-pointer'>
			×
		</button>
	</div>
);
