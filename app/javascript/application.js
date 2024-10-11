// Import Bootstrap and its CSS
import 'bootstrap';
import "bootstrap/dist/css/bootstrap";

// Import and start Rails UJS
import Rails from "@rails/ujs";
Rails.start();

// Import Turbo and Controllers
import "@hotwired/turbo-rails"
import "controllers"

// If you need jQuery for some reason, you can still include it, but it's not required for Bootstrap 5
import $ from 'jquery';
window.jQuery = $;
window.$ = $;
