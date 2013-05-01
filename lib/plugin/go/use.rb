module Plugin
  module Go
    module Use include Plugin::Use
      def self.included(mod)
        mod.add_hook(:toplevel) do
          main_use_fn do
            use_common
            add_to_GOPATH(raw("$1/go"))
          end
        end
      end
    end
  end
end
