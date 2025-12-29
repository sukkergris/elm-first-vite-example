import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from "vite";
import elm from 'vite-plugin-elm-watch';
import devMetaTagPlugin from './vite-plugin-dev-meta.mjs';

export default defineConfig(({ command, mode }) => ({
  publicDir: "public",

  build: {
    outDir: "wwwroot",
    emptyOutDir: true,
  },

  plugins: [
    elm(),
    devMetaTagPlugin(command, mode),
    tailwindcss()
  ],

  server: {
    open: 'http://happy.now',
    port: 3456,
    host: "0.0.0.0", // Listen on all network interfaces to allow access from the host machine
    allowedHosts: ["host.docker.internal", "www.happy.now", "happy.now", "www.happy.dev", "happy.dev"],
  },
  preview: {
    host: '0.0.0.0',
    port: 3456,
    strictPort: true,
    allowedHosts: ["www.happy.dev", "happy.dev"]
  },
}));