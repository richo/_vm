module Plugin::Ruby
  module Use include Plugin::Use
    def __use!(var)
      super
      __export("RUBYOPT", args[2])
      __if(cmp(raw("$UID"), Fixnum).gt(0)) do |c|
        c.then do
          gem_path = raw("$HOME/.gem/$(basename #{var})")
          __export("GEM_HOME", gem_path)
          __export("GEM_ROOT", gem_path)
          __export("GEM_PATH", gem_path)
          add_to_PATH(raw("#{gem_path}/bin"))
        end
      end
    end
  end
end
