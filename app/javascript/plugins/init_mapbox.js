import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
// [...]
// if (mapElement) {
//   // [...]
//   map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
//                                       mapboxgl: mapboxgl }));
// }

const initMapbox = () => {
  const mapElement = document.getElementById('map');


  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/bennorsk/ckfnxja6109of1auj0b8u6fls'
      // That is the access token to this map
      //pk.eyJ1IjoiYmVubm9yc2siLCJhIjoiY2tmNmpnZzZvMHRmNTMwcWR1NnVocnZmdCJ9.H1zfqOnfwYWPFKh5yA3eXA
    });
    // here the markers defintion used to be
    const markers = JSON.parse(mapElement.dataset.markers);
     console.log(markers)
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    fitMapToMarkers(map, markers);
  }

};

const boatSelected = () => {


  // boats = document.querySelectorAll(".boat");
  // boats.addEventListener("click", (element) => {
  //   console.log("it moves in here")
  //   mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  //   const map = new mapboxgl.Map({
  //     container: 'map',
  //     style: 'mapbox://styles/bennorsk/ckfnxja6109of1auj0b8u6fls'
  //     // That is the access token to this map
  //     //pk.eyJ1IjoiYmVubm9yc2siLCJhIjoiY2tmNmpnZzZvMHRmNTMwcWR1NnVocnZmdCJ9.H1zfqOnfwYWPFKh5yA3eXA
  //   });
  //   // here the markers defintion used to be

  //   let markers = [{lat: boat.address.lat, lng: boat.address.lng}];
  //    console.log(markers)
  //   markers.forEach((marker) => {
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .addTo(map);
  //   });
  //   fitMapToMarkers(map, markers);

  //   boat = event.currentTarget;
  // });
}






const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};



const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `${image_url('white_bg.png')}`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';

    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup) // add this
      .addTo(map);
  });
};



export { initMapbox, boatSelected };

