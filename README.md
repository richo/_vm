_vm
===

A generic version manager.

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

# Installing

\_vm uses the environment variable `__name_LIST` (ie, `__php_LIST`) to find versions. in my .zshrc I have:

```bash
__php_LIST=~/.php/versions/*
__ruby_LIST=~/.rvm/rubies/*
```

If you don't want to pull in the ruby dependencies, you can fetch the current versions from

`https://raw.github.com/richo/_vm/latest/dist/_${language}`, ie

* ruby: https://raw.github.com/richo/_vm/latest/dist/_ruby
* php: https://raw.github.com/richo/_vm/latest/dist/_php
* go: https://raw.github.com/richo/_vm/latest/dist/_go
* python: https://raw.github.com/richo/_vm/latest/dist/_python
* aws: https://raw.github.com/richo/_vm/latest/dist/_aws

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

Currently, I've implemented a version manager for ruby. You can get it by
running the `_ruby` script.

It works like this:

```
elektra ⚡ _ruby
   default
   jruby-1.7.0
   rbx-head
   ruby-1.9.3-p194
   ruby-1.9.3-p286
   ruby-1.9.3-p327
   ruby-1.9.3-p374
   topaz-head
elektra ⚡ ruby -v
ruby 1.8.7 (2012-02-08 patchlevel 358) [universal-darwin12.0]
elektra ⚡ _ruby ruby-1.9.3-p327
elektra ⚡ ruby -v
ruby 1.9.3p327 (2012-11-10 revision 37606) [x86_64-darwin12.2.1]
elektra ⚡ _ruby
   default
   jruby-1.7.0
   rbx-head
   ruby-1.9.3-p194
   ruby-1.9.3-p286
 * ruby-1.9.3-p327
   ruby-1.9.3-p374
   topaz-head
elektra ⚡
```

The scripts that ship with `_vm` will use `_` as the prefix, in order to expose
managers called `_foo` etc, however if you want to use something else
(Especially on ZSH, which reserves `_foo` as the completion function for
`foo`), you should consider changing the prefix in the manager to something
else. I use `,`.

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
