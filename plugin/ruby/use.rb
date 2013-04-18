module Plugin::Ruby::Use
  def self.included(mod)
    mod.add_hook(:toplevel) do
      __function("_#{name}_use") do
        __export("#{name}_ROOT", raw("$1"))
        __export("RUBYOPT", raw("$2"))

        __export("PATH", raw("${#{name}_ROOT}/bin:$PATH"))
      end
    end
  end
end
