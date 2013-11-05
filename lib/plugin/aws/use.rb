module Plugin::AWS
  module Use include Plugin::Use
    def __use!(var)
      __export(root(:var), raw(var + "/credentials"))
    end
  end
end
