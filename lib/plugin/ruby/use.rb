module Plugin::Ruby
  module Use include Plugin::Use
    def __use!(var)
      super
      __export("RUBYOPT", args[2])
      gem_path = raw("$HOME/.gem/$(basename #{var})")
      set_gem_paths!(gem_path)
      add_to_PATH(raw("#{gem_path}/bin"))
    end
  end
end
