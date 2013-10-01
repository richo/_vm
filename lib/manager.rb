if File.exists?(shell_proxy_path = File.expand_path("../../shell-proxy/lib", __FILE__))
  $:.unshift shell_proxy_path
end
require 'shell-proxy'

UNDERSCORE_VM_VERSION = "0.0.6"

module Plugin
  def self.uuid
    @current_id ||= 0
    @current_id += 1
    :"unique_plugin_method_#{@current_id}"
  end
end

Dir[File.expand_path("../plugin/*.rb", __FILE__)].each do |f|
  require f
end
Dir[File.expand_path("../plugin/**/*.rb", __FILE__)].each do |f|
  require f
end

class Manager
  @@plugins = Hash.new { |h, k| h[k] = Array.new }
  @@name = nil
  @@prefix = "_"

  # include FragmentManager
  def self.create_fragment(fragment_name)
    fragment = raw("${_#{@@name}_#{fragment_name}_fragment}")
    fragment_var = bare("_#{@@name}_#{fragment_name}_fragment")

    self.send(:define_method, (:"add_to_#{fragment_name}")) do |path|
      send(:"remove_fragment_from_#{fragment_name}")
      __if(bare(%<[ -n "#{fragment}" ]>)) do |c|
        c.then { __set(fragment_var, raw("#{fragment}:#{path}")) }
        c.else { __set(fragment_var, raw("#{path}")) }
      end
      send(:"add_fragment_to_#{fragment_name}")
    end

    self.send(:define_method, (:"remove_fragment_from_#{fragment_name}")) do
      __if(bare(%<[ -n "#{fragment}" ]>)) do |c|
        c.then do
          r = replace(fragment).with("")
          r.and("::").with(":")
          r.and("^:").with("")
          r.and(":$").with("")

          __export(fragment_name, r.exec("$#{fragment_name}"))
        end
      end
    end

    self.send(:define_method, (:"add_fragment_to_#{fragment_name}")) do
      __export(fragment_name, raw("#{fragment}:${#{fragment_name}}"))
    end

    self.send(:define_method, (:"reset_fragment_for_#{fragment_name}")) do
      send(:"remove_fragment_from_#{fragment_name}")
      __set(fragment_var, bare("''"))
    end
  end

  def self.add_hook(to, &block)
    uuid = Plugin.uuid
    @@plugins[to] << uuid
    define_method(uuid, &block)
  end

  def self.set_prefix(prefix)
    @@prefix = prefix
  end

  def root(type=nil)
    if type == :var
      raw("#{name}_ROOT")
    else
      raw("${#{name}_ROOT}")
    end
  end

  def self.name(n)
    @@name = n
  end

  def name
    @@name || self.class.to_s.downcase
  end

  attr_reader :io
  def initialize(io=nil)
    @io = io
    self.class.create_fragment("PATH")
  end

  def build
  __main__(io) do
    def for_all(name, iter, &block)
      __for(bare("${__#{name}_LIST}"), iter, &block)
    end
    build_main
    @@plugins[:toplevel].each do |plugin|
      self.send(plugin)
    end
  end
  end

  def build_main
    __function("#{@@prefix}#{name}") do
      __case(args[1]) do |c|
        c.when("-h|--help") do
          echo raw("usage: _#{name} [version] [opts]")
        end
        c.when("-v|--version") do
          echo raw("_#{name} version #{UNDERSCORE_VM_VERSION}")
        end
        c.when("system") do
          __call("_#{name}_reset")
        end
        @@plugins[:main_case].each do |plugin|
          self.send(plugin, c)
        end
      end
    end
  end
end
