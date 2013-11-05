module Contrib
  module ZSH
    def self.included(mod)
      mod.set_prefix ","
    end
  end
end
