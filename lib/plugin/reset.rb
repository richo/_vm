module Plugin::Reset
  def self.included(mod)
    if mod.is_a? Class
      mod.add_hook(:toplevel) do
        main_reset_fn do
          reset_common
        end
      end
    end
  end

  def main_reset_fn(&block)
    __function("_#{name}_reset", &block)
  end


  def reset_common
    reset_fragment_for_PATH
    __if(bare(%<[ -n "#{root}" ]>)) do |c|
      c.then do
        __unset(root :var)
      end
    end
  end
end
