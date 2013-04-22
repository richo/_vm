module Plugin::Python
  module Reset include Plugin::Reset
    def self.included(mod)
      mod.add_hook(:toplevel) do
        main_reset_fn do
          reset_common
          reset_fragment_for_PYTHONPATH
        end
      end
    end
  end
end
