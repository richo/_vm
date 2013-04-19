module Plugin::Use
  def use_common
    __export("#{name}_ROOT", raw("$1"))
    __set("__#{name}_path_fragment", path_fragment)
    __export("PATH", raw("#{path_fragment}:$PATH"))
  end
end
