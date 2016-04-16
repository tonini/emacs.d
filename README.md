[![License GPL 3][badge-license]](http://www.gnu.org/licenses/gpl-3.0.txt)

# My personal emacs settings

After using a prefabricated emacs setup for a long time, I came to the point where I wanted to build
together my own custom emacs stack.

This setup is slim and management and should give any other coder who consider or always wanted to
create an own custom emacs setting, a good start.

It’s a single big `init.el`, containing only `use-package` declarations for all the built-in and 3rd party packages I use. These declarations have all the configuration and setup for the specific packages.

There’s also `lisp/` which has my own personal extensions and libraries with custom functions, etc. These libraries are loaded like normal packages with `use-package` in `init.el.`

## Requirements

* Emacs 24 or greater.
* [Tester](https://github.com/tonini/tester.el) Run all tests through the same pipeline.
* [Karma](https://github.com/tonini/karma.el) Karma Test Runner Emacs Integration.

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the `init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```shell
git clone https://github.com/tonini/emacs.d.git ~/.emacs.d
```

## Support

If you hit any problems, please first ensure that you are using the latest version of this code,
and that you have updated your packages to the most recent available versions.
If you still experience problems, you can find me on [IRC](http://de.wikipedia.org/wiki/Internet_Relay_Chat) channels **#elixir-lang** and **#emacs** under the nickname **tonini**.

## Contributing

Contributions are very welcome!

1. Fork `emacs.d`
2. Create a topic branch - `git checkout -b my_branch`
4. Push to your branch - `git push origin my_branch`
5. Send me a pull-request for your topic branch
6. That's it!

## License

Copyright © 2016 Samuel Tonini

Distributed under the GNU General Public License, version 3

[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
