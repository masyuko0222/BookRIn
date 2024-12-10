import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	static targets = ['flash'];

	close() {
		if (this.flashTarget) {
			this.flashTarget.style.transition = 'opacity 0.5s ease';
			this.flashTarget.style.opacity = '0';
			setTimeout(() => this.flashTarget.remove(), 500);
		}
	}
}
