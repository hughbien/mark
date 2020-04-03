# Mark

Command line utility to preview markdown in a browser.

## Usage

Render a markdown file in your browser:

```
mark <file.md>
```

By default, this renders markdown into the target file `~/.mark/index.html`. You can specify a
different target location via the `-t`/`--target` option. Or set the `MARK_TARGET` env var:

```
mark --target /path/to/target.html <file.md>
```

You can create your own template too. Just create an HTML template, the string `#{BODY}` will be
substituted with the rendered markdown. The default location for the template is
`~/.mark/template.html`. Or you can specify it with `-T`/`--template`.

```
mark --template /path/to/template.html <file.md>
```

Mark uses `open` to open the rendered file by default. To override this, either use the `MARK_OPEN`
env var or `-o`/`--open` option. Pass a string with the `%` placeholder, which will be the filename.

```
mark --open "firefox %" <file.md>
```

## Development

Run via:

```
bin/build run [options] file1.md file2.md ...
```

Run specs via:

```
bin/build spec
```

Build a release via:

```
bin/build release
```

Clean build artifcats with:

```
bin/build clean
```

## TODO

* add binary package and install instructions to README
