import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

import { initNav } from '../plugins/init_sidebar';

global.initMapbox = initMapbox;

initMapbox();

initNav();



