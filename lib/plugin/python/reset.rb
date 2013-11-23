module Plugin::Python
  module Reset include Plugin::Reset
    def __reset!
      super
      reset_fragment_for_PYTHONPATH
      __unset("JYTHON_HOME")
    end
  end
end
