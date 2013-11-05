module Plugin::Ruby
  module Reset include Plugin::Reset
    def __reset!
      super
      __unset("RUBYOPT")
      __unset("GEM_HOME")
      __unset("GEM_ROOT")
      __unset("GEM_PATH")
    end
  end
end
