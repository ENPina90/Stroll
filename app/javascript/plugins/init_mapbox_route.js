import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

var start = JSON.parse(document.getElementById("start").dataset.coordinates)

const buildMap = (mapElement) => {
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
      map.addLayer({
        id: 'point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: start
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#ffffff'
        }
      });
      map.addLayer({
        id: 'end-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: end
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.addLayer({
        id: 'loc-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc1
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.addLayer({
        id: 'loc2-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc2
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.addLayer({
        id: 'loc3-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc3
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.addLayer({
        id: 'loc4-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc4
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.addLayer({
        id: 'loc5-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc5
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6',
        }
      });
      map.addLayer({
        id: 'loc6-point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: loc6
              }
            }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#5F96A6'
        }
      });
      map.on('load', function () {
        map.resize();
      });
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
      instructions.innerHTML = '<br><span class="duration">Trip duration: ' + Math.floor(data.duration / 60) + ' min 🚴 </span>' + tripInstructions;
    }
  };
  req.send();
}


export { initMapboxRoute };

