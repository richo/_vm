module Plugin::AWS
  module Reset include Plugin::Reset
    def __reset!
      __unset(root :var)
    end
  end
end
