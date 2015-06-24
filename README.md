_vm
===

A generic version manager.

Frustrated with the fragmentation of the *vm/*env ecosystem, I set out to write
a framework for emitting targeted, pure shell codebases.

My goals were:

* Extensibility
* Code reuse
* Ease of development, by abstracting away all the fiddly bits in writing posix code

# Should I use _vm?

Do you want to manage more than one type of thing? If the answer is yes, then probably.

\_vm's architecture means that bugs are more difficult to introduce, and easier
to fix permantly, in the same way the Rails makes it easier to write lots of
webapps with minimal code, \_vm makes it possible to generate lots of version
managers with minimal code.

### _vm vs rvm/chruby/pythonbrew/virtualenv

_vm is pretty much entirely a drop in replacement for chruby (while the DSL is
novel, the implementation is pretty much directly derived from chruby)

By virtue of it's hands off nature, it can play very well with other
ecosystems. For example symlinking virtualenvs or homebrew builds into your
root directory will Just Work.

# Installing

\_vm uses the environment variable `__name_LIST` (ie, `__php_LIST`) to find versions. in my .zshrc I have:

```bash
__php_LIST=~/.php/versions/*
__ruby_LIST=~/.rvm/rubies/*
```

Then simply source the relevant shell file:

```bash
source _php
source _ruby
```

If you don't want to pull in the ruby dependencies, you can fetch the current versions from

`https://raw.github.com/richo/_vm/latest/dist/_${language}`, ie

* ruby: https://raw.github.com/richo/_vm/latest/dist/_ruby
* php: https://raw.github.com/richo/_vm/latest/dist/_php
* go: https://raw.github.com/richo/_vm/latest/dist/_go
* python: https://raw.github.com/richo/_vm/latest/dist/_python
* aws: https://raw.github.com/richo/_vm/latest/dist/_aws
* rust: https://raw.github.com/richo/_vm/latest/dist/_rust

Which will always include the latest release.

### ZSH

The `_vm` generation process is aware of ZSH's existance. ZSH wants to use
`_foo` as a completion function for `foo`, as such `_vm` spits out functions
called `,foo`. Builds are linked below:

* ruby: https://raw.github.com/richo/_vm/latest/dist/,ruby
* php: https://raw.github.com/richo/_vm/latest/dist/,php
* go: https://raw.github.com/richo/_vm/latest/dist/,go
* python: https://raw.github.com/richo/_vm/latest/dist/,python
* aws: https://raw.github.com/richo/_vm/latest/dist/,aws
* rust: https://raw.github.com/richo/_vm/latest/dist/,rust

ZSH builds also include tab completion.

### Homebrew

\_vm ships with a shell helper called `brew!` that will setup an ephemeral
`_vm` helper in the current shell. It currently depends on some zsh specifics.

You use it like:

```
# Somewhere in your init files:
source ../path/to/_vm/contrib/brew.sh

# Then in your shell
prompt% brew! go
# Assuming you've set _VM_USE_ZSH
prompt% ,go
   1.2.1
prompt% ,go 1.2.1
prompt% which go
/usr/local/Cellar/go/1.2.1/bin/go
prompt%
```

# Contrib Modules

There are examples, as well as optional modules you may want, included in the
repo, for example requiring the `prompt.rb` in `contrib` will give you access
to

```ruby
include Contrib::Prompt
```

to give you a function suitable for including current version in your prompt, eg

```bash
_ruby prompt # "system" or "2.0.0-p195" etc
```

# Current Status

It's at the point where the framework mostly works. There are also a few really
useful plugins for other languages.

A really quick tour:

```
xenia % ,rust system
xenia % ,ruby system
xenia % echo $DYLD_LIBRARY_PATH

xenia % ,rust 0.11.0-2eb3ab1
xenia % echo $DYLD_LIBRARY_PATH
/Users/richo/.rusts/0.11.0-2eb3ab1/lib
xenia % ,ruby 2.0.0
xenia % echo $GEM_PATH
/Users/richo/.gem/2.0.0:
xenia % ,gem::add ~/code/some-dev-gem
xenia % echo $GEM_PATH
/Users/richo/.gem/2.0.0:/Users/richo/code/some-dev-gem:
xenia % which nmap
/usr/local/bin/nmap
xenia % brew! nmap
xenia % ,nmap
   6.46
xenia % ,nmap 6.46
xenia % which nmap
/usr/local/Cellar/nmap/6.46/bin/nmap
xenia %
```

You'll notice that I'm using the prefix `,`. You can either set this directly
in your managers, or the ZSH contrib module will use `,` by default.

# Development

Requires [shell-proxy][2] which is basically only used by _vm, so it's
submoduled in for convenience to make development more straightforward.

Currently you can either build it on the fly, or fetch prebuilt scripts (for
example if your system doesn't have ruby)

```bash

# I'm using my RVM rubies with _vm
__ruby_LIST=~/.rvm/rubies/*
# In zsh, I'd love to know how to do this in bash:
emulate sh -c "`ruby _ruby`"

# Or if you don't want to be on the bleeding edge
mkdir -p ~/.vm
ruby _ruby > ~/.vm/_ruby
# in ${SHELL}rc
source ~/.vm/_ruby

# in a posix compatible sh

eval "`ruby _ruby`"

```
If you want to rebuild _vm at runtime, you should install shell-proxy as a
submodule, which _vm checks for before doing a (very expensive) rubygems lookup.

# Other platforms

I would love to know how to make this work with other languages/platforms.

I basically just need to know what environment variables the language expects
to see (and a link to a convenient way to get/build the binaries would be nice).
Feel free to [open an issue](https://github.com/richo/_vm/issues)

# Credits

* [@mpapis](https://twitter.com/mpapis): For the original skype call that lead me down this train of thought.
* [@postmodern](https://twitter.com/postmodern_mod3): For [chruby][1], from which most of the core was directly derived.


[1]: https://github.com/postmodern/chruby
[2]: https://github.com/richo/shell-proxy
