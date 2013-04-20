module Plugin::Ruby::Use include Plugin::Use
  def self.included(mod)
    mod.add_hook(:toplevel) do
      main_fn do
        use_common
        __export("RUBYOPT", raw("$2"))
      end
    end
  end
end
