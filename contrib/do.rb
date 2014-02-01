module Contrib
  module Do
    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:main_case) do |c|
          c.when("do") do
            shift # Shift `do` off $*
            for_all(name, "i") do
              __if(cmp(raw(basename raw("$i")), String).eq(args[1])) do |ci|
                ci.then do
                  shift # Shift $ruby_version off $*
                  __eval raw("PATH=#{with_fragment_in_PATH(raw("$i/bin"))} \"$@\"")
                  __return(0)
                end
              end
            end
            echo raw("#{prefix}#{name}: unknown #{name}: #{args[1]}")
          end
        end
      end
    end
  end
end
