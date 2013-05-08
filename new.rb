#!/usr/bin/env ruby
require 'erb'
name = ARGV[0]
class_name = name[0].upcase
class_name << name[1..-1]

proxy_type = ARGV[1] || "PosixProxy"

puts ERB.new(DATA.read).result(binding)
__END__
require File.expand_path('../lib/manager', __FILE__)

class <%= class_name %> < Manager
  include <%= proxy_type %>

  name <%= name %>
  set_prefix "${_VM_PREFIX:-_}"

  include Plugin::List
  # Needs to be included last of the main_case plugins
  include Plugin::Set

  include Plugin::Ruby::Use
  include Plugin::Ruby::Reset
end

_<%= name %> = <%= class_name %>.new
_<%= name %>.build

