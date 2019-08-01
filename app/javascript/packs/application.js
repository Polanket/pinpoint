import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox, placeMarkers } from '../plugins/init_mapbox';

import { initNav } from '../plugins/init_sidebar';

import { initSelect2 } from '../plugins/init_select2';

// import { animateMarkers } from '../plugins/init_markerAnimation';

// import '../plugins/search_box';

window.mapbox = initMapbox;

window.placeMarkers = placeMarkers;

initNav();

initMapbox();

initSelect2();

// animateMarkers();
