module Plugin
  module Go
    module Reset include Plugin::Reset
      def self.included(mod)
        mod.add_hook(:toplevel) do
          main_reset_fn do
            reset_common
            reset_fragment_for_GOPATH
          end
        end
      end
    end
  end
end
