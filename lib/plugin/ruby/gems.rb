module Plugin::Ruby
  module Gems

    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:toplevel) do
          __function("#{mod.prefix}#{name}::gems") do
            __case(args[1]) do |c|
              c.when("--reset") do
                __if(__set?(root)) do |c|
                  c.then do
                    __use!(raw("$(basename #{root})"))
                  end
                  c.else do
                    reset_gem_paths!
                  end
                end
              end
              c.when("*") do
                set_gem_paths!(raw("#{"`pwd`"}/#{args[1]}"))
              end
            end
          end
        end
      end
    end

    def set_gem_paths!(path)
      __export("GEM_HOME", path)
      __export("GEM_ROOT", path)
      __export("GEM_PATH", path)
    end

    def reset_gem_paths!
      __unset("GEM_HOME")
      __unset("GEM_ROOT")
      __unset("GEM_PATH")
    end
  end
end
