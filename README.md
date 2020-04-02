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
crystal run src/cli.cr -- [options] file1.md file2.md ...
```

Run specs via:

```
crystal spec
```

Build a release via:

```
crystal build src/cli.cr --release
```

# TODO

* add markdown render to specific target (via --target option)
* add env target option (via MARK_TARGET)
* add opening target in browser (via open)
* add open command option (via --open=)
* add open env var option (via MARK_OPEN)
* add template override (via ~/.mark/template.html)
* add template override (via --template option)
* add binary package and install instructions to README
* handle error: no sources given
* handle error: invalid sources (eg cannot read or does not exist)
* handle error: invalid target (eg cannot write)
* handle error: invalid template (eg cannot read or does not exist)
* handle error: invalid open command
