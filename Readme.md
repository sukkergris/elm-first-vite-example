# How to re-create this example

## First let's setup vite to handle building Elm

1. >elm init
2. >touch src/Main.elm
3. >npm init
4. >npm install vite-plugin-elm-watch --save-dev OR -D
5. >npm install site-config-loader
6. >touch index.html
7. ! Emmet Abbreviation (To fill index.html)
8. >touch src/main.js
9. Add to index.html
```html
<body>
    <div id="app"></div>
    <script type="module" src="/src/main.js"></script>
</body>
```
10. Add to src/index.js
```js
import Main from './Main.elm';
let app = Main.init({
  node: document.getElementById('app')
})
```
11. touch vite.config.mjs
```js
import { defineConfig } from "vite";
import elm from 'vite-plugin-elm-watch';

export default defineConfig(({ command }) => ({
  publicDir: "public",

  build: {
    outDir: "wwwroot",
    emptyOutDir: true,
  },

  plugins: [elm()],

  server: {
    open: true,
    port: 3456,
    host: "0.0.0.0", // Listen on all network interfaces to allow access from the host machine
    allowedHosts: ["host.docker.internal", "localhost"],
  },
}));
```
12. >npm install vite -D
13. >npx vite

## Utilize site-config-loader

### Add configurations

1. >mkdir -p public/config && touch public/config/environmentVariables.json && touch public/config/environmentVariables.local.json

2. Add some variables to the two files. Eg.
```js
{
    "API_URL": "https://api.[environment].com",
    "ANOTHER_VARIABLE": "[environment]_value"
}
```
3. Run `npx vite` or `npm run dev` and explore the Console

### Add html rewrite using vite transformIndexHtml

Since we havn't added any meta data to set the environment `site-config-loader` will default to `local` based on the url, which is set to localhost.

1. >touch vite-plugin-dev-meta.mjs
2. Add content
```js
export default function devMetaTagPlugin(command) {
  if (command !== 'serve') return null;

  return {
    name: 'html-transform-dev-only',
    transformIndexHtml(html) {
      return html.replace(
        '</head>',
        '<meta name="environment-name" content="production"></head>'
      );
    }
  };
}
```
3. Add usage of the plugin to `vite.config.mjs`
```js
  import devMetaTagPlugin from './vite-plugin-dev-meta.mjs';
  ...
  plugins: [
    elm(),
    devMetaTagPlugin(command)
  ],
```
3. Run `npx vite` or `npm run dev` and explore the Console

