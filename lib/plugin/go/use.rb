module Plugin
  module Go
    module Use include Plugin::Use
      def self.included(mod)
        mod.add_hook(:toplevel) do
          main_use_fn do
            use_common
            __export("GOROOT", root)
          end
        end
      end
    end
  end
end
