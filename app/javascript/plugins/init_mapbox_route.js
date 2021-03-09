import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
const buildMap = (mapElement) => {
  var start = JSON.parse(document.getElementById("start").dataset.coordinates)
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map-route',
    style: 'mapbox://styles/cynthiahbg/ckltc5cd115oj17qpefl0odpq',
    center: start,
    zoom: 13
  });
};
// const addMarkersToMap = (map, markers) => {
//   markers.forEach((marker) => {
//     const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
//     new mapboxgl.Marker()
//       .setLngLat([marker.lng, marker.lat])
//       .setPopup(popup)
//       .addTo(map);
//   });
// };
// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
//   map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
// };
const initMapboxRoute = () => {
  const mapElement = document.getElementById('map-route');
  if (mapElement) {
    const map = buildMap(mapElement);
    // const markers = JSON.parse(mapElement.dataset.markers);
    // addMarkersToMap(map, markers);
    // fitMapToMarkers(map, markers);
    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
    map.on('load', function () {
      var start = JSON.parse(document.getElementById("start").dataset.coordinates)
      var end = JSON.parse(document.getElementById("end").dataset.coordinates)
      var locationsCoordinates = []
      var locationsDescriptions = []
      var locations = document.querySelectorAll(".location")
      locations.forEach(location => {
        locationsCoordinates.push(JSON.parse(location.dataset.coordinates))
        locationsDescriptions.push(location.dataset.description)
      });
      getRoute(end, map);
      map.addControl(
        new mapboxgl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true
          },
          trackUserLocation: true
        })
      );
      var emptyArray = [{
        'type': 'Feature',
          'properties': {
            'description':
              '<strong>📍You are here</strong>'
            },
          'geometry': {
            'type': 'Point',
              'coordinates': start
            }}]
      locationsCoordinates.forEach(function(element, i) {
        emptyArray.push({'type': 'Feature',
          'properties': {
            'description': locationsDescriptions[i]
              },
            'geometry': {
              'type': 'Point',
              'coordinates': element}})
          });
      map.loadImage(
        '../assets/right_color.png',
        function (error, image) {
          if (error) throw error;
          map.addImage('custom-marker', image);
          map.addSource('points', {
            'type': 'geojson',
            'data': {
              'type': 'FeatureCollection',
              'features': emptyArray
          }});
          map.on('click', 'symbols', function (e) {
            var coordinates = e.features[0].geometry.coordinates.slice();
            var description = e.features[0].properties.description;
            while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
              coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
            }
            new mapboxgl.Popup()
              .setLngLat(coordinates)
              .setHTML(description)
              .addTo(map);
          });
          map.addLayer({
            'id': 'symbols',
            'type': 'symbol',
            'source': 'points',
            'layout': {
              'icon-image': 'custom-marker',
              'icon-size': 0.06
            }
          });
        }
      );
      getRoute(end, map);
    });
  }
};
function getRoute(end, map) {
  var start = JSON.parse(document.getElementById("start").dataset.coordinates)
  var locationsCoordinates = []
  var locations = document.querySelectorAll(".location")
  locations.forEach(location => {
    locationsCoordinates.push(JSON.parse(location.dataset.coordinates))
  })
  var string = ''
  locationsCoordinates.forEach(i => string += ';' + i[0] + ',' +i[1] )
  var url = 'https://api.mapbox.com/directions/v5/mapbox/walking/' + start[0] + ',' + start[1] +  string + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  console.log(url)
  var req = new XMLHttpRequest();
  req.open('GET', url, true);
  req.onload = function () {
    var json = JSON.parse(req.response);
    var data = json.routes[0];
    var route = data.geometry.coordinates;
    var geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    if (map.getSource('route')) {
      map.getSource('route').setData(geojson);
    } else { // otherwise, make a new request
      map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: geojson
            }
          }
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#0c6073',
          'line-width': 3,
          'line-opacity': 0.3,
        }
      });
    }
    var instructions = document.getElementById('instructions');
    var steps = data.legs[0].steps;
    var tripInstructions = [];
    for (var i = 0; i < steps.length; i++) {
      tripInstructions.push('<br><li>' + steps[i].maneuver.instruction) + '</li>';
      instructions.innerHTML = '<br><span class="directions">Directions</span>' + tripInstructions;
      // instructions.innerHTML = '<br><span class="duration">Trip duration: ' + Math.floor(data.duration / 60) + ' min 🚴 </span>' + tripInstructions;
    }
  };
  req.send();
}
export { initMapboxRoute };
