module Plugin::Set
  def self.included(mod)
    mod.add_hook(:main_case) do |c|
      c.when("*") do
        for_all(name, "i") do
          __if(cmp(raw(basename raw("$i")), String).eq(args[1])) do |ci|
            ci.then do
              shift
              __call("_#{name}_use", raw("$i"), raw("$*"))
              __return(raw("$?"))
            end
          end
        end
        echo raw("_#{name}: unknown #{name}: #{args[1]}")
      end
    end
  end
end
