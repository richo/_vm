module Plugin::Use
  def self.included(mod)
    if mod.is_a? Class
      mod.add_hook(:toplevel) do
        __function("_#{name}_use") do
          use_common
        end
      end
    end
  end

  def use_common
    __export("#{name}_ROOT", raw("$1"))
    __set("__#{name}_path_fragment", path_fragment)
    __export("PATH", raw("#{path_fragment}:$PATH"))
  end
end
