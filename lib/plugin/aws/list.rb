module Plugin::AWS
  module List include Plugin::List
    def self.included(mod)
      mod.add_hook(:main_case) do |c|
        c.when("") do
          bare("star")
          for_all(name, "i") do
            __if(cmp(raw("$i" + "/credentials"), String).eq(root)) do |ci|
              ci.then do
                __set('star', "*")
              end
              ci.else do
                __set('star', " ")
              end
              end
            echo raw(' $star $(basename $i)')
          end
        end
      end
    end
  end
end
