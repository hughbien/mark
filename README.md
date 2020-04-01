# Mark

Command line utility to preview markdown in a browser.

## Usage

Render a markdown file in your browser:

```
mark <file.md>
```

By default, this renders markdown into the file `~/.mark/mark.html`. You can specify a different
file location via the `-f`/`--file` option. Or set the `MARKFILE` env var:

```
mark --file /path/to/file.html <file.md>
```

You can create your own template too. Just create an HTML template, the string `#{BODY}` will be
substituted with the rendered markdown. The default location for the template is
`~/.mark/template.html`. Or you can specify it with `-t`/`--template`.

```
mark --template /path/to/template.html <file.md>
```

Mark uses `open` to open the rendered file by default. To override this, either use the `MARKOPEN`
env var or `-o`/`--open` option. Pass a string with the `%` placeholder, which will be the filename.

```
mark --open "firefox %" <file.md>
```

## TODO

* add compilation to binary
* add option parser
* add markdown renderer (to ~/.mark/mark.html)
* add markdown render to specific file (via --file option)
* add opening file in browser (via open)
* add template
* add template override (via --template option)
* add env file option (via MARKFILE)
* add template option (via ~/.mark/template.html)
* add open command option (via --open=)
* add open env var option (via MARKOPEN)
* add binary package and install instructions to README
