module Plugin::Rust
  module Use include Plugin::Use
    def __use!(var)
      super
      path = raw("#{var}/lib")
      __case(raw("$(uname -s)")) do |c|
        c.when("Darwin") do
          __export("DYLD_LIBRARY_PATH", path)
        end
        c.else do
          __export("LD_LIBRARY_PATH", path)
        end
      end
    end
  end
end
