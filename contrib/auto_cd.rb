module Contrib
  module AutoCd
    def self.included(mod)
      if mod.is_a? Class
        mod.add_hook(:toplevel) do
          if ENV['_VM_USE_ZSH']
            cd_fn = setup_zsh_completion
            __eval("add-zsh-hook chpwd #{cd_fn}")
          else
            setup_bash_completion
          end
        end
      end
    end

    def setup_zsh_completion
      fn_name = "_#{name}_switcher"
      __function(fn_name) do
        comparator = FSComparator.new
        # Relative is OK, we're installing ourselves as a post-cd hook
        __if(comparator.exists?(".#{name}-version")) do |ci|
          ci.then do
            __use! raw("`cat .#{name}-version`")
          end
        end
      end
      return fn_name
    end

    def setup_bash_completion
    end
  end
end
