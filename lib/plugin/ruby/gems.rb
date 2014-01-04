module Plugin::Ruby
  module Gems
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
