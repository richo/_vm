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
    __if(bare(%<[ -n #{root} ]>)) do |c|
      c.then do
        __eval("_#{name}_reset")
      end
    end
    __export("#{name}_ROOT", raw("$1"))
    add_to_path("${#{name}_ROOT}/bin")
  end
end
