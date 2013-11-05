module Plugin
  module Go
    module Reset include Plugin::Reset
      def __reset!
        super
        __unset("GOROOT")
      end
    end
  end
end
