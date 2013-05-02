# vim: ft=ruby

Gem::Specification.new do |s|
  s.name        = "_vm"
  s.version     = "0.0.3"
  s.authors     = ["Richo Healey"]
  s.email       = ["richo@psych0tik.net"]
  s.homepage    = "http://github.com/richo/_vm"
  s.summary     = "Generic version manager"
  s.description = s.summary

  s.add_dependency "shell-proxy"

  #s.add_development_dependency "rake"
  #s.add_development_dependency "mocha"
  #s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  if ENV['GEM_PRIVATE_KEY']
    s.signing_key = "#{ENV['GEM_PRIVATE_KEY']}/gem-private_key.pem"
    s.cert_chain  = ["#{ENV['GEM_PRIVATE_KEY']}/gem-public_cert.pem"]
  end
end


