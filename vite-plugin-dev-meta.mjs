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