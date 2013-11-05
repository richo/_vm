module Plugin::AWS
  module Reset include Plugin::Reset
    def self.included(mod)
      mod.add_hook(:toplevel) do
        main_reset_fn do
          __unset(root :var)
        end
      end
    end
  end
end
