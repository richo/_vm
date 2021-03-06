module Plugin::Rust
  module Reset include Plugin::Reset
    def __reset!
      super
      __case(raw("$(uname -s)")) do |c|
        c.when("Darwin") do
          __unset("DYLD_LIBRARY_PATH")
        end
        c.else do
          __unset("LD_LIBRARY_PATH")
        end
      end
    end
  end
end
