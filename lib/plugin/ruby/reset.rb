module Plugin::Ruby
  module Reset include Plugin::Reset
    def self.included(mod)
      mod.add_hook(:toplevel) do
        main_reset_fn do
          reset_common
          __unset("RUBYOPT")
          __unset("GEM_HOME")
          __unset("GEM_ROOT")
          __unset("GEM_PATH")
        end
      end
    end
  end
end
