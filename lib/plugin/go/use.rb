module Plugin
  module Go
    module Use include Plugin::Use
      def __use!(var)
        super
        __export("GOROOT", root)
      end
    end
  end
end
