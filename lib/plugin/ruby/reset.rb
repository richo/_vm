module Plugin::Ruby
  module Reset include Plugin::Reset
    def __reset!
      super
      __unset("RUBYOPT")
      reset_fragment_for_GEM_PATH
      reset_gem_paths!
    end
  end
end
