module Plugin
  module Go
    module Reset include Plugin::Reset
      def self.included(mod)
        mod.add_hook(:toplevel) do
          main_reset_fn do
            reset_common
            __unset("GOROOT")
          end
        end
      end
    end
  end
end
