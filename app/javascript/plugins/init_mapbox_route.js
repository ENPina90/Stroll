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
      var loc1 = JSON.parse(document.getElementById("loc1").dataset.coordinates)
      var loc2 = JSON.parse(document.getElementById("loc2").dataset.coordinates)
      var loc3 = JSON.parse(document.getElementById("loc3").dataset.coordinates)
      var loc4 = JSON.parse(document.getElementById("loc4").dataset.coordinates)
      var loc5 = JSON.parse(document.getElementById("loc5").dataset.coordinates)
      var loc6 = JSON.parse(document.getElementById("loc6").dataset.coordinates)
      getRoute(end, map);
      map.addControl(
        new mapboxgl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true
          },
          trackUserLocation: true
        })
      );
      map.loadImage(
        '../assets/right_color.png',
        function (error, image) {
          if (error) throw error;
          map.addImage('custom-marker', image);
          map.addSource('points', {
            'type': 'geojson',
            'data': {
              'type': 'FeatureCollection',
              'features': [
                {
                  'type': 'Feature',
                  'properties': {
                    'description':
                      '<strong>Make it Mount Pleasant</strong><p><a href="http://www.mtpleasantdc.com/makeitmtpleasant" target="_blank" title="Opens in a new window">Make it Mount Pleasant</a> is a handmade and vintage market and afternoon of live entertainment and kids activities. 12:00-6:00 p.m.</p>'
                  },
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc1
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {},
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc2
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {},
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc3
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {
                    'description':
                      '<strong>Waldeckpark</strong><p> Das etwa zwei Hektar große Gelände wurde um 1604 als Pestfriedhof für die Petri-Gemeinde angelegt. Nach und nach entstand aus dem Friedhof eine Grünanlage, die ab dem Jahr 1870 teilweise von den Cöllner Bewohnern kostenfrei genutzt werden konnte...<a href=""> read more</a></p>'
                  },
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc4
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {},
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc5
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {
                    'description':
                      '<strong>Design Academy Berlin</strong><p> Encouraging students from all over the world to translate their curiosity and passion into a career. Being committed to working with teachers...<a href=""> read more</a></p>'
                  },
                  'geometry': {
                    'type': 'Point',
                    'coordinates': loc6
                  }
                },
                {
                  'type': 'Feature',
                  'properties': {
                    'description':
                      '<strong>📍You are here</strong>'
                  },
                  'geometry': {
                    'type': 'Point',
                    'coordinates': start
                  }
                },
                // {
                //   'type': 'Feature',
                //   'properties': {},
                //   'geometry': {
                //     'type': 'Point',
                //     'coordinates': end
                //   }
                // }
              ]
            }
          });
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
  var loc1 = JSON.parse(document.getElementById("loc1").dataset.coordinates)
  var loc2 = JSON.parse(document.getElementById("loc2").dataset.coordinates)
  var loc3 = JSON.parse(document.getElementById("loc3").dataset.coordinates)
  var loc4 = JSON.parse(document.getElementById("loc4").dataset.coordinates)
  var loc5 = JSON.parse(document.getElementById("loc5").dataset.coordinates)
  var loc6 = JSON.parse(document.getElementById("loc6").dataset.coordinates)
  var url = 'https://api.mapbox.com/directions/v5/mapbox/walking/' + start[0] + ',' + start[1] + ';' + loc1[0] + ',' + loc1[1] + ';' + loc2[0] + ',' + loc2[1] + ';' + loc3[0] + ',' + loc3[1] + ';' + loc4[0] + ',' + loc4[1] + ';' + loc5[0] + ',' + loc5[1] + ';' + loc6[0] + ',' + loc6[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
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

