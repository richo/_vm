module Plugin::Python
  module Use include Plugin::Use
    def __use!(var)
      super
      __if(cmp(raw("$UID"), Fixnum).gt(0)) do |c|
        c.then do
          python_path = raw("$HOME/.pip/$(basename #{var})")
          add_to_PYTHONPATH(python_path)
        end
      end
    end
  end
end
