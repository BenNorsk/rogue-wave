import places from 'places.js';

document.addEventListener('turbolinks:load', () => {
(function() {
  var placesAutocomplete = places({
    appId: 'plT520BOCQY1',
    apiKey: 'c9727f8316c766c44757111c62d86381',
    container: document.querySelector('.street_address'),
    templates: {
      value: function(suggestion) {
        return suggestion.name;
      }
    }
  }).configure({
    type: 'address'
  });
  placesAutocomplete.on('change', function resultSelected(e) {
    document.querySelector('.city_address').value = e.suggestion.city || '';
    document.querySelector('.country_address').value = e.suggestion.country || '';
  });
})();
});
