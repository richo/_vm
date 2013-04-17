require 'shell-proxy'

UNDERSCORE_VM_VERSION = "0.0.0"

class Manager
  def initialize(name)
    @name = name
  end

  def build(io = nil)
  name = @name
  ShellProxy.new.__main__(io) do
    def for_all(name, iter, &block)
      __for(bare("${__#{name}_LIST}"), iter, &block)
    end

    __function("_#{name}") do
      __case(raw("$1")) do |c|
        c.when("-h|--help") do
          echo raw("usage: $0 [version] [opts]")
        end
        c.when("-v|--version") do
          echo raw("$0 version #{UNDERSCORE_VM_VERSION}")
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
end
