module Contrib
  module Prompt
    def self.included(mod)
      mod.add_hook(:main_case) do |c|
        c.when("prompt") do
          __if(__set?(root)) do |ci|
            ci.then do
              echo basename(root)
            end
            ci.else do
              echo "system"
            end
          end
        end
      end
    end
  end
end
