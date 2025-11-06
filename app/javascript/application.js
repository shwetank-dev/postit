// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import * as bootstrap from 'bootstrap';

// Re-init dropdowns after Turbo replaces the DOM
document.addEventListener('turbo:load', () => {
  document
    .querySelectorAll('[data-bs-toggle="dropdown"]')
    .forEach((el) => new bootstrap.Dropdown(el));
});
import '@hotwired/turbo-rails';
