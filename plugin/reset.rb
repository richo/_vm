module Plugin::Reset
  def self.included(mod)
    mod.add_hook(:toplevel) do
      __function("_#{name}_reset") do

        __if(bare(%<[ -n "#{path_fragment}" ]>)) do |c|
          c.then do
            # XXX This needs a command stack to work out where to put the results
            __eval(%<export PATH=$(echo "${PATH}"| sed \
-e "s|#{path_fragment}||" \
-e "s|::|:|" \
-e "s|^:||" \
-e "s|:$||")>)
          end
        end

        __if(bare(%<[ -n "#{root}" ]>)) do |c|
          c.then do
            __unset(root :var)
          end
        end

      end
    end
  end
end
