module Plugin::Set
  def self.included(mod)
    mod.add_hook(:main_case) do |c|
      c.when("*") do
        for_all(name, "i") do
          __if(raw(%<[ `basename \"$i\"` = "$1" ]>)) do |ci|
            ci.then do
              shift
              __eval("_#{name}_use \"$i\" \"$*\"")
              __return(raw("$?"))
            end
          end
        end
        echo raw("_#{name}: unknown #{name}: $1")
      end
    end
  end
end
