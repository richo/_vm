module Plugin::Ruby
  module Use include Plugin::Use
    def self.included(mod)
      mod.add_hook(:toplevel) do
        main_use_fn do
          use_common
          __export("RUBYOPT", raw("$2"))
          __if(%<[ $UID -gt 0 ]>) do |c|
            c.then do
              gem_path = raw("$HOME/.gem/$(basename $1)")
              __export("GEM_HOME", gem_path)
              __export("GEM_ROOT", gem_path)
              __export("GEM_PATH", gem_path)
              add_to_PATH(raw("#{gem_path}/bin"))
            end
          end
        end
      end
    end
  end
end
