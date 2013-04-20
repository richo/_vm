_vm
===

A generic version manager.

So far, I've generically reimplemented [chruby][1]. The only point of this
experiment is to see whether or not machine generated posix shell is even sane.

Requires [shell-proxy][2] which is so alpha it's not even really published.
Pull it down and stick it in your load path.

If you want to play with it in it's current encarnation, you would want to do something like

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

# Other platforms

I would love to know how to make this work with other languages/platforms.

I basically just need to know what environment variables the language expects
to see (and a link to a convenient way to get/build the binaries would be nice).
Feel free to [open an issue](https://github.com/richo/_vm/issues)


[1]: https://github.com/postmodern/chruby
[2]: https://github.com/richo/shell-proxy
