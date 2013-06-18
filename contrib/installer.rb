module Contrib
  def self.Installer(script_path)
    @@script_path = script_path
    Module.new do
      def self.included(mod)
        script_path = @@script_path
        mod.add_hook(:main_case) do |c|
          c.when("install") do
            __call(script_path, raw("$1"), raw("$2"))
          end
        end
      end
    end
  end
end
