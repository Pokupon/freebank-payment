# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freebank-payment/version'

Gem::Specification.new do |gem|
  gem.name          = 'freebank-payment'
  gem.version       = FreebankPayment::VERSION
  gem.authors       = ['Alexei Curguzchin']
  gem.email         = ["alexei.curguzchin@pokupon.ua"]
  gem.description   = %q{Process request and response from Freebank of Credit Dnepr Bank}
  gem.summary       = %q{Process request and response from Freebank of Credit Dnepr Bank}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.add_development_dependency 'rspec'
end
