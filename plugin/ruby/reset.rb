module Plugin::Ruby::Reset include Plugin::Reset
  def self.included(mod)
    mod.add_hook(:toplevel) do
      main_reset_fn do
        reset_common
      end
    end
  end
end
