// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// Import and start Rails UJS
import Rails from "@rails/ujs";
Rails.start();

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

//= require jquery
//= require jquery_ujs
//= require_tree .

