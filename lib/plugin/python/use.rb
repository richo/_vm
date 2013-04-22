module Plugin::Python
  module Use include Plugin::Use
    def self.included(mod)
      mod.add_hook(:toplevel) do
        main_use_fn do
          use_common
          __if(%<[ $UID -gt 0 ]>) do |c|
            c.then do
              python_path = raw("$HOME/.pip/$(basename $1)")
              add_to_PYTHONPATH(python_path)
            end
          end
        end
      end
    end
  end
end
