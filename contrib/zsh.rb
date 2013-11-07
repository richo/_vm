module Contrib
  module ZSH
    def self.included(mod)
      prefix = ","
      mod.set_prefix prefix

      mod.add_hook(:toplevel) do
        completer_fn = setup_completion
        __eval("compctl -K #{completer_fn} #{prefix}#{name}")
      end
    end

    def setup_completion
      fn_name = "_#{name}_completer"
      __function(fn_name) do
        __set("reply", bare("(#{__defaults.map{ |d| __escapinate(d) }.join(" ")})"))
        for_all(name, "i") do
          __eval("reply+=($(basename $i))")
        end
      end
      return fn_name
    end
  end
end
