require "../mark"

module Mark::Template
  # Default HTML template for rendered markdown. If no other template is specified, use this!
  DEFAULT_HTML = <<-HTML
  <!doctype html>
  <html>
  <head>
  <title>Markdown Preview</title>
  <style>
  html, body, div, span, object, iframe,h1, h2, h3, h4, h5, h6, p, blockquote, 
  pre,a, abbr, acronym, address, big, cite, code,del, dfn, em, img, ins, kbd, q, 
  s, samp,small, strike, strong, sub, sup, tt, var,dl, dt, dd, ol, ul, li,
  fieldset, form, label, legend,table, caption, tbody, tfoot, thead, tr, th, td { 
    margin: 0; padding: 0; border: 0; outline: 0; font-weight: inherit;
    font-style: inherit;
    vertical-align: baseline; 
  }
  body { text-align: center; font-size: 13px; background: #efefef;
    line-height: 1.7em; color: #333; width: 100%; height: 100%;
    font-family: lucida grande, helvetica, sans-serif; }
  h1,h2,h3,h4,h5,h6 { font-weight: bold; font-family: Copperplate / Copperplate Gothic Light, sans-serif; }
  h1 { margin: 48px 0 24px; color: #111; border-bottom: 1px solid #e0e0e0; 
    padding-bottom: 6px; font-size: 3.2em; line-height: 1em; }
  h1 + p, h1 + ol, h1 + ul { margin-top: -12px; }
  h2, h3, h4, h5, h6 { margin: 24px 0; color: #111; }
  h2 + p, h2 + ol, h2 + ul,
  h3 + p, h3 + ol, h3 + ul,
  h4 + p, h4 + ol, h4 + ul,
  h5 + p, h5 + ol, h5 + ul,
  h6 + p, h6 + ol, h6 + ul { margin-top: -12px; }
  h2 { font-size: 2.4em; }
  h3 { font-size: 1.8em; }
  h3 { font-size: 1.6em; }
  h4 { font-size: 1.4em; }
  h5 { font-size: 1.2em; }
  h6 { font-size: 1em; }
  a { color: #a37142; text-decoration: none; }
  a:hover { color: #234f32; }
  .fragment-anchor + h1, h1:first-child { margin-top: 0; }
  select, input, textarea { font: 99% lucida grande, helvetica, sans-serif; }
  pre, code { font-family: Lucida Console, Monaco, monospace; }
  ol { list-style: decimal; }
  ul { list-style: disc; }
  ol, ul { margin: 24px 0 24px 1.7em; }
  p + ol, p + ul { margin-top: -16px; }
  ol:last-child, ul:last-child { margin-bottom: 0; }
  table { border-collapse: collapse; border-spacing: 0; margin: 24px 0; width: 100%; }
  table tbody tr:nth-child(odd) td { background-color: #efefef; }
  table th, table td { border: 1px solid #e0e0e0; padding: 4px; }
  table th { font-weight: bold; }
  caption, th, td { text-align: left; font-weight: normal; }
  blockquote:before, blockquote:after,q:before, q:after { content: ''; }
  blockquote, q { quotes: "" ""; }
  em { font-style: italic; }
  strong { font-weight: bold; }
  p { margin: 24px 0; }
  p:first-child { margin-top: 0; }
  p:last-child { margin-bottom: 0; }
  #main { width: 640px; margin: 60px auto; text-align: left; position: relative;
    left: 0; }
  .section { padding: 48px; background: #fff; -webkit-box-shadow: 0 0 4px #ccc; 
    -moz-box-shadow: 0 0 4px #ccc; margin-bottom: 48px; }
  .section blockquote { border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;
    background: #eee; padding: 12px 48px; position: relative;
    right: 48px; width: 100%; font-style: italic;
    font-family: "Times New Roman", Times, serif; }
  .section pre { border-top: 1px solid #000; border-bottom: 1px solid #000;
     color: #fff; background: #2b2b2b; width: 100%; padding: 12px 48px;
     position: relative; right: 48px; font-family: Monaco, monospace;
     overflow-x: auto; }
  .section pre code { font-weight: normal; }
  .section code { font-family: Monaco, monospace; font-weight: bold; }
  .section strong { border-bottom: 1px dashed #aaa; }
  .nav-layout #main { left: 115px; }
  </style>
  \#{HEAD}
  </head>
  <body>
    <div id="main">
      <div class="section">\#{BODY}</div>
    </div>
    \#{SCRIPT}
  </body>
  </html>
  HTML
end
