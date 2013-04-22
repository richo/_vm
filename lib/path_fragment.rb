module FragmentManager
  def fragment(type=nil)
    if type == :var
      bare("_#{name}_fragment")
    else
      raw("${_#{name}_fragment}")
    end
  end

  def add_to_path(path)
    remove_fragment_from_path
    __set(fragment(:var), raw("#{fragment}:#{path}"))
    add_fragment_to_path
  end

  def remove_fragment_from_path
    __if(bare(%<[ -n "#{fragment}" ]>)) do |c|
      c.then do
        __eval(%<export PATH=$(echo "${PATH}"| sed \
-e "s|#{fragment}||" \
-e "s|::|:|" \
-e "s|^:||" \
-e "s|:$||")>)
      end
    end
  end

  def add_fragment_to_path
    __export("PATH", raw("#{fragment}:$PATH"))
  end

  def reset_fragment
    remove_fragment_from_path
    __set(fragment(:var), bare("''"))
  end
end
