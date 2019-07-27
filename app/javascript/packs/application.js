import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox, placeMarkers } from '../plugins/init_mapbox';

import { initNav } from '../plugins/init_sidebar';

import '../plugins/search_box';

window.mapbox = initMapbox;

window.placeMarkers = placeMarkers;

initNav();

initMapbox();





