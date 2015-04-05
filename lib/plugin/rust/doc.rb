module Plugin::Rust
  module Doc
    def path_for(crate)
      __escapinate(raw("#{root}/share/doc/rust/html/#{crate}/index.html"))
    end

    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:main_case) do |c|
          c.when("doc") do
            echo raw('Loading docs from ' + root)
            __case(args[2]) do |ca|
              ca.when("") do
                __eval("open #{path_for "std"}")
              end
              ca.else do
                __eval("open #{path_for args[2]}")
              end
            end
          end
        end
      end
    end
  end
end
