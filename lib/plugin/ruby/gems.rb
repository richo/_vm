module Plugin::Ruby
  module Gems
    def set_gem_paths!(path)
      __export("GEM_HOME", path)
      __export("GEM_ROOT", path)
    end

    def reset_gem_paths!
      __unset("GEM_HOME")
      __unset("GEM_ROOT")
    end

    def self.included(mod)
      if mod.is_a? Class
        mod.create_fragment("GEM_PATH")

        mod.add_hook(:toplevel) do
          __function(ns("#{prefix}gem", "add")) do
            add_to_GEM_PATH args[1]
          end
        end
      end
    end
  end
end
