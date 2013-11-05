module Plugin::Reset
  def __reset!
    reset_fragment_for_PATH
    __if(__set?(root)) do |c|
      c.then do
        __unset(root :var)
      end
    end
  end
end
