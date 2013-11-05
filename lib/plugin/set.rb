module Plugin::Set
  def self.included(mod)
    if mod.is_a? Class
      mod.add_hook(:main_case) do |c|
        c.when("*") do
          for_all(name, "i") do
            __if(cmp(raw(basename raw("$i")), String).eq(args[1])) do |ci|
              ci.then do
                __use!(raw("$i"))
                __return(0)
              end
            end
          end
          echo raw("_#{name}: unknown #{name}: #{args[1]}")
        end
      end
    end
  end
end
