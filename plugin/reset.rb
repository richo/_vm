module Plugin::Reset
  def self.included(mod)
    if mod.is_a? Class
      mod.add_hook(:toplevel) do
        reset_common
      end
    end
  end

  def reset_common
    __function("_#{name}_reset") do
      reset_fragment
      __if(bare(%<[ -n "#{root}" ]>)) do |c|
        c.then do
          __unset(root :var)
        end
      end
    end
  end
end
