module Plugin::AWS
  module Use include Plugin::Use
    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:toplevel) do
          main_use_fn do
            use_common
          end
        end
      end
    end

    def main_use_fn(&block)
      __function("_#{name}_use", &block)
    end

    def use_common
      __if(__set?(root)) do |c|
        c.then do
          __call("_#{name}_reset")
        end
      end
      __export(root(:var), raw(args[1] + "/credentials"))
    end
  end
end
