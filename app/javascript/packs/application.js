// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap';
import 'dropzone';

import "../plugins/flatpickr"
import '../plugins/init_autocomplete'

// typed effect on banner
import '../plugins/typed_banner';
import '../components/live_price_calc';



//JS for Maps
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
document.addEventListener('turbolinks:load', () => {
  initMapbox();
})

//Bookings Tabs
import '../components/bookings_tab.js.erb'
import { bookingsTab } from '../components/bookings_tab.js.erb'
document.addEventListener('turbolinks:load', () => {
  bookingsTab();
})


// Import stimulus controllers
import 'controllers';



console.log(">>> Application.js loaded")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
