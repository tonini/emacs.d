[![License GPL 3][badge-license]](http://www.gnu.org/licenses/gpl-3.0.txt)

# My personal emacs settings

After using a prefabricated emacs setup for a long time, I came to the point where I wanted to build
together my own custom emacs stack.

This setup is slim and management and should give any other coder who consider or always wanted to
create an own custom emacs setting, a good start.

For package dependency managagement I use [Cask](https://github.com/cask/cask), because it's great. As you can see in the directory tree below,
the structure is quite straightforward.

```shell
├── Cask
├── README.md
├── init.el
├── parts
│   ├── coffee-prt.el
│   ├── completion-prt.el
│   ├── custom-prt.el
│   ├── display-prt.el
│   ├── elixir-prt.el
│   ├── emacs-lisp-prt.el
│   ├── ...
│   ├── ...
│   ├── ...
│   └── ...
├── snippets
├── test
└── themes
```

## Requirements

* Emacs 24 or greater.
* [Cask](https://github.com/cask/cask) to manage dependencies.

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the `init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```shell
git clone https://github.com/tonini/emacs.d.git ~/.emacs.d
```

To install all the dependencies:

```shell
$ cd ~/.emacs.d
$ cask install
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

Copyright © 2015 Samuel Tonini

Distributed under the GNU General Public License, version 3

[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
