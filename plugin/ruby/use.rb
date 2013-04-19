module Plugin::Ruby::Use include Plugin::Use
  def self.included(mod)
    mod.add_hook(:toplevel) do
      __function("_#{name}_use") do
        use_common
        __export("RUBYOPT", raw("$2"))
      end
    end
  end
end
