module Plugin::Use
  def __use!(var)
    if self.respond_to? :__reset!
      __if(__set?(root)) do |c|
        c.then do
          __reset!
        end
      end
    end
    __export(root(:var), var)
    add_to_PATH("#{root}/bin")
  end
end
