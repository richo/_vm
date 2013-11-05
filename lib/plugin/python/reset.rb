module Plugin::Python
  module Reset include Plugin::Reset
    def __reset!
      super
      reset_fragment_for_PYTHONPATH
    end
  end
end
