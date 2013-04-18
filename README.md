_vm
===

A generic version manager.

So far, I've generically reimplemented [chruby][1]. The only point of this
experiment is to see whether or not machine generated posix shell is even sane.

Requires [shell-proxy][2] which is so alpha it's not even really published.
Pull it down and stick it in your load path.

If you want to play with it in it's current encarnation, you would want to do something like

```bash

# In zsh, I'd love to know how to do this in bash:
emulate sh -c "`ruby _ruby`"

# in a posix compatible sh

eval "`ruby _ruby`"

```

If you want to do this often, you shouldn't use rubygems and instead shim your
`RUBY_PATH` directly to shell-proxy, rubygems lookups are slow enough that you
don't want to do them every time.

[1]: https://github.com/postmodern/chruby
[2]: https://github.com/richo/shell-proxy
