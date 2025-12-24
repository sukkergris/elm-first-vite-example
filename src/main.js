import { loadEnvironmentVariables } from 'site-config-loader';
import Main from './Main.elm';

const config = await loadEnvironmentVariables();
console.log('Loaded configuration: ', config);
//`let app` Is needed for Hot Module Replacement while developing
let app = Main.init({
  node: document.getElementById('app')
})