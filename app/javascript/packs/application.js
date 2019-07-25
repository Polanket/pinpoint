import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox'

global.initMapbox = initMapbox;
initMapbox();
