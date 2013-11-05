module Plugin::Use
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
    if self.respond_to? :__reset!
      __if(__set?(root)) do |c|
        c.then do
          __reset!
        end
      end
    end
    __export(root(:var), args[1])
    add_to_PATH("${#{name}_ROOT}/bin")
  end
end
