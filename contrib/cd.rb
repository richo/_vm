module Contrib
  module Cd
    def self.included(mod)
      mod.add_hook(:main_case) do |c|
        c.when("cd") do
          __if(__set?(root)) do |ci|
            ci.then do
              __eval("cd #{root}")
            end
          end
        end
      end
    end
  end
end
