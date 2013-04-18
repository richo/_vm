require 'shell-proxy'

UNDERSCORE_VM_VERSION = "0.0.0"

class Manager < ShellProxy
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def build(io = nil)
  __main__(io) do
    def for_all(name, iter, &block)
      __for(bare("${__#{name}_LIST}"), iter, &block)
    end
    build_main
  end
  end

  def build_main
    __function("_#{name}") do
      __case(raw("$1")) do |c|
        c.when("-h|--help") do
          echo raw("usage: _#{name} [version] [opts]")
        end
        c.when("-v|--version") do
          echo raw("_#{name} version #{UNDERSCORE_VM_VERSION}")
        end
        c.when("") do
          local bare("star")
          for_all(name, "i") do
            __if(raw("[[ \"$i\" == $#{name}_ROOT ]]")) do |ci|
              ci.then do
                __eval('star="*"')
              end
              ci.else do
                __eval('star=" "')
              end
            end
            echo raw(' $star $(basename $i)')
          end
        end
        c.when("system") do
          __eval("_#{name}_reset")
        end
        c.when("*") do
          for_all(name, "i") do
            __if(raw("[[ `basename \"$i\"` == *$1* ]]")) do |ci|
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
end
