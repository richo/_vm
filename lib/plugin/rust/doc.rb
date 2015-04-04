module Plugin::Rust
  module Doc
    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:main_case) do |c|
          c.when("doc") do
            std_root = "/share/doc/rust/html/std/index.html"
            echo raw('Loading docs from ' + root)
            __eval("open " + __escapinate(raw(root + std_root)))
          end
        end
      end
    end
  end
end
